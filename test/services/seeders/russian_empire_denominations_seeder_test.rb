require 'test_helper'

class RussianEmpireDenominationsSeederTest < ActiveSupport::TestCase
  test 'creates RUB_IMP currency if missing and seeds coins and notes' do
    assert_nil Currency.find_by(code: 'RUB_IMP')
    seeder = Seeders::RussianEmpireDenominationsSeeder.new
    assert_nothing_raised { seeder.seed_all }

    imp = Currency.find_by(code: 'RUB_IMP')
    assert_not_nil imp
    assert imp.is_active

    [
      '1 Ruble (silver)',
      '5 Rubles (gold)',
      '100 Rubles (note)'
    ].each do |name|
      assert CurrencyDenominationVariant.joins(:currency_denomination).where(currency_denominations: { currency_id: imp.id }).find_by(name: name)
    end
  end
end


