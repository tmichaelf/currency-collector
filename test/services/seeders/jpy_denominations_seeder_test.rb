require 'test_helper'

class JpyDenominationsSeederTest < ActiveSupport::TestCase
  test 'creates JPY currency if missing and seeds coins and notes' do
    assert_nil Currency.find_by(code: 'JPY')
    seeder = Seeders::JpyDenominationsSeeder.new
    assert_nothing_raised { seeder.seed_all }

    jpy = Currency.find_by(code: 'JPY')
    assert_not_nil jpy
    assert jpy.is_active

    %w[1\ Yen\ (coin) 500\ Yen\ (coin) 1,000\ Yen\ (note) 10,000\ Yen\ (note)].each do |name|
      assert CurrencyDenominationVariant.joins(:currency_denomination).where(currency_denominations: { currency_id: jpy.id }).find_by(name: name)
    end
  end
end


