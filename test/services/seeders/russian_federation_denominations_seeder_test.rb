require 'test_helper'

class RussianFederationDenominationsSeederTest < ActiveSupport::TestCase
  test 'creates RUB currency if missing and seeds coins and notes' do
    assert_nil Currency.find_by(code: 'RUB')
    seeder = Seeders::RussianFederationDenominationsSeeder.new
    assert_nothing_raised { seeder.seed_all }

    rub = Currency.find_by(code: 'RUB')
    assert_not_nil rub
    assert rub.is_active

    [
      '1 Ruble (coin)',
      '10 Rubles (bi-metallic coin)',
      '100 Rubles (note)',
      '5,000 Rubles (note)'
    ].each do |name|
      assert CurrencyDenomination.find_by(currency: rub, name: name)
    end
  end
end


