require 'test_helper'

class SovietDenominationsSeederTest < ActiveSupport::TestCase
  test 'creates SUR currency if missing and seeds coins and notes' do
    assert_nil Currency.find_by(code: 'SUR')
    seeder = Seeders::SovietDenominationsSeeder.new
    assert_nothing_raised { seeder.seed_all }

    sur = Currency.find_by(code: 'SUR')
    assert_not_nil sur
    assert sur.is_active

    [
      '1 Kopek (1961–1991)',
      '20 Kopeks (1961–1991)',
      '1 Ruble (1961 series)'
    ].each do |name|
      assert CurrencyDenomination.find_by(currency: sur, name: name)
    end
  end
end


