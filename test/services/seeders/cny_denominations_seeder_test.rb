require 'test_helper'

class CnyDenominationsSeederTest < ActiveSupport::TestCase
  test 'creates CNY currency if missing and seeds coins and notes' do
    assert_nil Currency.find_by(code: 'CNY')
    seeder = Seeders::CnyDenominationsSeeder.new
    assert_nothing_raised { seeder.seed_all }

    cny = Currency.find_by(code: 'CNY')
    assert_not_nil cny
    assert cny.is_active

    [
      '1 Jiao',
      '1 Yuan (coin)',
      '5 Yuan (note)',
      '100 Yuan (note)'
    ].each do |name|
      assert CurrencyDenomination.find_by(currency: cny, name: name)
    end
  end
end


