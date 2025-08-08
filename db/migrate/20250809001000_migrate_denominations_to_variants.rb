class MigrateDenominationsToVariants < ActiveRecord::Migration[8.0]
  def up
    # Ensure the collections can reference variants during migration
    unless column_exists?(:currency_collections, :currency_denomination_variant_id)
      add_column :currency_collections, :currency_denomination_variant_id, :bigint
      add_foreign_key :currency_collections, :currency_denomination_variants
      add_index :currency_collections, :currency_denomination_variant_id
    end

    # Create base denominations grouped by currency/value/type
    say_with_time 'Migrating currency_denominations to base + variants' do
      groups = execute(<<~SQL)
        SELECT currency_id, denomination_type, value
        FROM currency_denominations
        GROUP BY currency_id, denomination_type, value
      SQL

      groups.each do |g|
        currency_id = g['currency_id']
        denom_type = g['denomination_type']
        value = g['value']

        # Choose a generic base name: e.g., 0.01 coin -> Penny if USD else like "0.01 coin"
        base_name = generic_base_name(currency_id, denom_type, value)
        base = execute(<<~SQL)
          INSERT INTO currency_denominations (currency_id, name, value, denomination_type, year_introduced, year_discontinued, is_active, created_at, updated_at)
          VALUES (#{currency_id}, #{quote(base_name)}, #{value}, #{quote(denom_type)}, NULL, NULL, TRUE, NOW(), NOW())
          RETURNING id
        SQL
        base_id = base.first['id']

        # Move all rows in this group into variants
        rows = execute(<<~SQL)
          SELECT * FROM currency_denominations
          WHERE currency_id = #{currency_id}
            AND denomination_type = #{quote(denom_type)}
            AND value = #{value}
            AND id <> #{base_id}
        SQL

        rows.each do |row|
          variant = execute(<<~SQL)
            INSERT INTO currency_denomination_variants (
              currency_denomination_id, name, year_introduced, year_discontinued, mint_mark, composition, design_type, series, is_active, created_at, updated_at
            ) VALUES (
              #{base_id},
              #{quote(row['name'])},
              #{row['year_introduced'] || 'NULL'},
              #{row['year_discontinued'] || 'NULL'},
              #{quote(row['mint_mark'])},
              #{quote(row['composition'])},
              #{quote(row['design_type'])},
              #{quote(row['series'])},
              #{row['is_active'] ? 'TRUE' : 'FALSE'},
              NOW(), NOW()
            ) RETURNING id
          SQL
          variant_id = variant.first['id']

          # Repoint collections to the variant and base denomination
          execute(<<~SQL)
            UPDATE currency_collections
            SET currency_denomination_variant_id = #{variant_id},
                currency_denomination_id = #{base_id}
            WHERE currency_denomination_id = #{row['id']}
          SQL

          # Now it is safe to delete the original denomination row
          if row['id'].to_i != base_id.to_i
            execute("DELETE FROM currency_denominations WHERE id = #{row['id']}")
          end
        end
      end
    end
  end

  def down
    # Rebuild denominations from variants (best-effort)
    say_with_time 'Reconstructing currency_denominations from variants' do
      rows = execute(<<~SQL)
        SELECT v.*, d.currency_id, d.value, d.denomination_type
        FROM currency_denomination_variants v
        JOIN currency_denominations d ON d.id = v.currency_denomination_id
      SQL

      rows.each do |r|
        execute(<<~SQL)
          INSERT INTO currency_denominations (
            currency_id, name, value, denomination_type, year_introduced, year_discontinued, is_active, created_at, updated_at, mint_mark, composition, design_type, series
          ) VALUES (
            #{r['currency_id']},
            #{quote(r['name'])},
            #{r['value']},
            #{quote(r['denomination_type'])},
            #{r['year_introduced'] || 'NULL'},
            #{r['year_discontinued'] || 'NULL'},
            #{r['is_active'] ? 'TRUE' : 'FALSE'},
            NOW(), NOW(),
            #{quote(r['mint_mark'])},
            #{quote(r['composition'])},
            #{quote(r['design_type'])},
            #{quote(r['series'])}
          )
        SQL
      end

      execute('DELETE FROM currency_denomination_variants')
    end
  end

  private

  # Simple heuristic: for USD map common values to names, else format value
  def generic_base_name(currency_id, denom_type, value)
    currency = select_value("SELECT code FROM currencies WHERE id = #{currency_id}")
    return formatted_base_name(denom_type, value) unless currency == 'USD'

    mapping = {
      'coin' => {
        '0.01' => 'Penny', '0.05' => 'Nickel', '0.10' => 'Dime', '0.25' => 'Quarter', '0.50' => 'Half Dollar', '1.0' => 'Dollar Coin'
      },
      'bill' => {
        '1.0' => 'One Dollar Bill', '2.0' => 'Two Dollar Bill', '5.0' => 'Five Dollar Bill', '10.0' => 'Ten Dollar Bill', '20.0' => 'Twenty Dollar Bill', '50.0' => 'Fifty Dollar Bill', '100.0' => 'One Hundred Dollar Bill'
      }
    }
    mapping.fetch(denom_type, {}).fetch(value.to_s, formatted_base_name(denom_type, value))
  end

  def formatted_base_name(denom_type, value)
    unit = denom_type == 'coin' ? 'coin' : 'bill'
    "#{value} #{unit}"
  end
end


