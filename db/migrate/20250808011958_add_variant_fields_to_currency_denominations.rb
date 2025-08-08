class AddVariantFieldsToCurrencyDenominations < ActiveRecord::Migration[8.0]
  def change
    add_column :currency_denominations, :mint_mark, :string
    add_column :currency_denominations, :composition, :string
    add_column :currency_denominations, :design_type, :string
    add_column :currency_denominations, :series, :string
  end
end
