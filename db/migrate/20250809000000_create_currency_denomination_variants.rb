class CreateCurrencyDenominationVariants < ActiveRecord::Migration[8.0]
  def change
    create_table :currency_denomination_variants do |t|
      t.references :currency_denomination, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :year_introduced
      t.integer :year_discontinued
      t.string :mint_mark
      t.string :composition
      t.string :design_type
      t.string :series
      t.boolean :is_active, default: true
      t.timestamps
    end
  end
end


