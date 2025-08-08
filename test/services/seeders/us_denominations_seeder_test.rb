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

    # spot check some denominations
    names = [
      'Lincoln Shield Cent',
      'Roosevelt Dime (Clad)',
      'American Women Quarters',
      'Kennedy Half Dollar (Clad)',
      'American Innovation Dollar',
      'One Hundred Dollar Bill (Small Size)'
    ]
    names.each do |n|
      assert CurrencyDenomination.find_by(currency: @usd, name: n), "Expected #{n} to be seeded"
    end

    before = CurrencyDenomination.where(currency: @usd).count
    assert_nothing_raised { seeder.seed_all }
    after = CurrencyDenomination.where(currency: @usd).count
    assert_equal before, after, 'Seeding should be idempotent'
  end
end


