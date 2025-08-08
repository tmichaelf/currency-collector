require 'test_helper'

class GbpDenominationsSeederTest < ActiveSupport::TestCase
  test 'creates GBP currency if missing and seeds coins and notes' do
    assert_nil Currency.find_by(code: 'GBP')
    seeder = Seeders::GbpDenominationsSeeder.new
    assert_nothing_raised { seeder.seed_all }

    gbp = Currency.find_by(code: 'GBP')
    assert_not_nil gbp
    assert gbp.is_active

    %w[1\ Penny 50\ Pence Two\ Pounds\ (coin) £5\ (polymer) £50\ (polymer)].each do |name|
      assert CurrencyDenominationVariant.joins(:currency_denomination).where(currency_denominations: { currency_id: gbp.id }).find_by(name: name)
    end
  end
end


