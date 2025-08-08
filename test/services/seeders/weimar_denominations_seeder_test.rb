require 'test_helper'

class WeimarDenominationsSeederTest < ActiveSupport::TestCase
  test 'creates WEIMAR currency if missing and seeds notes' do
    assert_nil Currency.find_by(code: 'WEIMAR')
    seeder = Seeders::WeimarDenominationsSeeder.new
    assert_nothing_raised { seeder.seed_all }

    weimar = Currency.find_by(code: 'WEIMAR')
    assert_not_nil weimar
    assert weimar.is_active

    [
      '1,000 Mark (Papiermark)',
      '1 Million Mark (Papiermark)',
      '1 Rentenmark',
      '100 Rentenmark'
    ].each do |name|
      assert CurrencyDenominationVariant.joins(:currency_denomination).where(currency_denominations: { currency_id: weimar.id }).find_by(name: name)
    end
  end
end


