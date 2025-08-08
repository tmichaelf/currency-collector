require 'test_helper'

class UsDenominationsSeederTest < ActiveSupport::TestCase
  setup do
    @usd = Currency.find_by(code: 'USD') || Currency.create!(
      code: 'USD', name: 'United States Dollar', country: 'United States', description: 'USD', is_active: true
    )
  end

  test 'seeds US denominations and is idempotent' do
    seeder = Seeders::UsDenominationsSeeder.new
    assert_nothing_raised { seeder.seed_all }

    # spot check base + variant
    base = CurrencyDenomination.find_by(currency: @usd, value: 0.01, denomination_type: 'coin')
    assert_not_nil base
    assert_equal 'Penny', base.name

    names = [
      'Lincoln Shield Cent',
      'Roosevelt Dime (Clad)',
      'American Women Quarters',
      'Kennedy Half Dollar (Clad)',
      'American Innovation Dollar',
      'One Hundred Dollar Bill (Small Size)'
    ]
    names.each do |n|
      assert CurrencyDenominationVariant.joins(:currency_denomination).where(currency_denomination: { currency_id: @usd.id }).find_by(name: n), "Expected #{n} to be seeded"
    end

    before = CurrencyDenominationVariant.joins(:currency_denomination).where(currency_denominations: { currency_id: @usd.id }).count
    assert_nothing_raised { seeder.seed_all }
    after = CurrencyDenominationVariant.joins(:currency_denomination).where(currency_denominations: { currency_id: @usd.id }).count
    assert_equal before, after, 'Seeding should be idempotent'
  end
end


