class CreateCurrencyCollections < ActiveRecord::Migration[8.0]
  def change
    create_table :currency_collections do |t|
      t.references :user, null: false, foreign_key: true
      t.references :currency_denomination, null: false, foreign_key: true
      t.integer :quantity
      t.string :condition
      t.text :notes
      t.date :acquired_date

      t.timestamps
    end
  end
end
