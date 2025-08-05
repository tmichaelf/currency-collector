class CreateCurrencyDenominations < ActiveRecord::Migration[8.0]
  def change
    create_table :currency_denominations do |t|
      t.references :currency, null: false, foreign_key: true
      t.string :name
      t.decimal :value
      t.string :denomination_type
      t.integer :year_introduced
      t.integer :year_discontinued
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
