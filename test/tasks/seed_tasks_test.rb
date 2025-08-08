require 'test_helper'
require 'rake'

class SeedTasksTest < ActiveSupport::TestCase
  setup do
    @rake = Rake::Application.new
    Rake.application = @rake
    @rake.load_rakefile
  end

  test 'db:seed:iso4217 runs without error' do
    assert_nothing_raised { @rake['db:seed:iso4217'].invoke }
    assert Currency.exists?
  end

  test 'db:seed:us_denominations runs without error' do
    Currency.find_or_create_by!(code: 'USD') { |c| c.name = 'United States Dollar'; c.country = 'United States'; c.description = 'USD'; c.is_active = true }
    assert_nothing_raised { @rake['db:seed:us_denominations'].invoke }
    assert CurrencyDenomination.where(currency: Currency.find_by(code: 'USD')).exists?
  end
end


