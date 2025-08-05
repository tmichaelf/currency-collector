class CreateCurrencies < ActiveRecord::Migration[8.0]
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :code
      t.string :country
      t.text :description
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
