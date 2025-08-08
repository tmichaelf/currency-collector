require 'test_helper'

class Iso4217CurrenciesSeederTest < ActiveSupport::TestCase
  test 'seeds missing ISO currencies and is idempotent' do
    # Ensure a currency not in fixtures is absent
    assert_nil Currency.find_by(code: 'GBP')

    seeder = Seeders::Iso4217CurrenciesSeeder.new
    assert_nothing_raised { seeder.seed_all }

    gbp = Currency.find_by(code: 'GBP')
    assert_not_nil gbp
    assert_equal 'United Kingdom', gbp.country
    assert gbp.is_active

    # Run again should not create duplicates
    before_count = Currency.count
    assert_nothing_raised { seeder.seed_all }
    assert_equal before_count, Currency.count
  end
end


