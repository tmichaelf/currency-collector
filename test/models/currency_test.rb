require "test_helper"

class CurrencyTest < ActiveSupport::TestCase
  def setup
    @currency = Currency.new(
      name: "Test Currency",
      code: "TEST",
      country: "Test Country",
      description: "A test currency",
      is_active: true
    )
  end

  test "should be valid" do
    assert @currency.valid?
  end

  test "name should be present" do
    @currency.name = nil
    assert_not @currency.valid?
  end

  test "code should be present" do
    @currency.code = nil
    assert_not @currency.valid?
  end

  test "code should be unique" do
    @currency.save
    duplicate_currency = @currency.dup
    assert_not duplicate_currency.valid?
  end

  test "country should be present" do
    @currency.country = nil
    assert_not @currency.valid?
  end

  test "display_name should return formatted name" do
    @currency.save
    assert_equal "Test Currency (TEST)", @currency.display_name
  end

  test "active scope should return only active currencies" do
    @currency.save
    inactive_currency = Currency.create!(
      name: "Inactive Currency",
      code: "INACT",
      country: "Test Country",
      is_active: false
    )
    
    assert_includes Currency.active, @currency
    assert_not_includes Currency.active, inactive_currency
  end
end
