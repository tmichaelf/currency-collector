# Create US Dollar currency
usd = Currency.find_or_create_by!(code: 'USD') do |currency|
  currency.name = 'United States Dollar'
  currency.country = 'United States'
  currency.description = 'The official currency of the United States of America'
  currency.is_active = true
end

# Create a default user
user = User.find_or_create_by!(email: 'collector@example.com') do |u|
  u.username = 'currency_collector'
  u.first_name = 'John'
  u.last_name = 'Doe'
end

# US Coin Denominations (Pennies)
[
  { name: 'Penny', value: 0.01, denomination_type: 'coin', year_introduced: 1793, year_discontinued: nil },
  { name: 'Nickel', value: 0.05, denomination_type: 'coin', year_introduced: 1866, year_discontinued: nil },
  { name: 'Dime', value: 0.10, denomination_type: 'coin', year_introduced: 1796, year_discontinued: nil },
  { name: 'Quarter', value: 0.25, denomination_type: 'coin', year_introduced: 1796, year_discontinued: nil },
  { name: 'Half Dollar', value: 0.50, denomination_type: 'coin', year_introduced: 1794, year_discontinued: nil },
  { name: 'Dollar Coin', value: 1.00, denomination_type: 'coin', year_introduced: 1794, year_discontinued: nil },
  { name: 'Two Dollar Bill', value: 2.00, denomination_type: 'bill', year_introduced: 1862, year_discontinued: nil },
  { name: 'Five Dollar Bill', value: 5.00, denomination_type: 'bill', year_introduced: 1861, year_discontinued: nil },
  { name: 'Ten Dollar Bill', value: 10.00, denomination_type: 'bill', year_introduced: 1861, year_discontinued: nil },
  { name: 'Twenty Dollar Bill', value: 20.00, denomination_type: 'bill', year_introduced: 1861, year_discontinued: nil },
  { name: 'Fifty Dollar Bill', value: 50.00, denomination_type: 'bill', year_introduced: 1861, year_discontinued: nil },
  { name: 'Hundred Dollar Bill', value: 100.00, denomination_type: 'bill', year_introduced: 1861, year_discontinued: nil }
].each do |denomination_data|
  CurrencyDenomination.find_or_create_by!(currency: usd, name: denomination_data[:name]) do |denomination|
    denomination.value = denomination_data[:value]
    denomination.denomination_type = denomination_data[:denomination_type]
    denomination.year_introduced = denomination_data[:year_introduced]
    denomination.year_discontinued = denomination_data[:year_discontinued]
    denomination.is_active = true
  end
end

puts "Seeded US currency data successfully!"
