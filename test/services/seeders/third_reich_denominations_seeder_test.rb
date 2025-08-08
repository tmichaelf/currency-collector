require 'test_helper'

class ThirdReichDenominationsSeederTest < ActiveSupport::TestCase
  test 'creates REICH currency if missing and seeds coins and notes' do
    assert_nil Currency.find_by(code: 'REICH')
    seeder = Seeders::ThirdReichDenominationsSeeder.new
    assert_nothing_raised { seeder.seed_all }

    reich = Currency.find_by(code: 'REICH')
    assert_not_nil reich
    assert reich.is_active

    [
      '1 Reichspfennig',
      '2 Reichsmark (coin)',
      '100 Reichsmark (note)'
    ].each do |name|
      assert CurrencyDenomination.find_by(currency: reich, name: name)
    end
  end
end


