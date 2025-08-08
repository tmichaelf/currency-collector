require 'test_helper'

class UsFractionalDenominationsSeederTest < ActiveSupport::TestCase
  setup do
    @usd = Currency.find_by(code: 'USD') || Currency.create!(
      code: 'USD', name: 'United States Dollar', country: 'United States', description: 'USD', is_active: true
    )
  end

  test 'seeds fractional denominations 3c..50c and is idempotent' do
    seeder = Seeders::UsFractionalDenominationsSeeder.new
    assert_nothing_raised { seeder.seed_all }

    expected_values = [0.03, 0.05, 0.10, 0.15, 0.25, 0.50]
    expected_values.each do |val|
      assert CurrencyDenomination.find_by(currency: @usd, value: val, denomination_type: 'bill')
    end

    before = CurrencyDenomination.where(currency: @usd, denomination_type: 'bill', value: expected_values).count
    seeder.seed_all
    after = CurrencyDenomination.where(currency: @usd, denomination_type: 'bill', value: expected_values).count
    assert_equal before, after
  end
end


