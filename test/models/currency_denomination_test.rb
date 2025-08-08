require "test_helper"

class CurrencyDenominationTest < ActiveSupport::TestCase
  def setup
    @currency = Currency.create!(
      name: "Test Currency",
      code: "TEST",
      country: "Test Country"
    )
    
    @denomination = CurrencyDenomination.new(
      currency: @currency,
      name: "Test Denomination",
      value: 1.00,
      denomination_type: "coin",
      year_introduced: 2020,
      is_active: true
    )
  end

  test "should be valid" do
    assert @denomination.valid?
  end

  test "name should be present" do
    @denomination.name = nil
    assert_not @denomination.valid?
  end

  test "value should be present" do
    @denomination.value = nil
    assert_not @denomination.valid?
  end

  test "value should be greater than zero" do
    @denomination.value = 0
    assert_not @denomination.valid?
    
    @denomination.value = -1
    assert_not @denomination.valid?
  end

  test "denomination_type should be present" do
    @denomination.denomination_type = nil
    assert_not @denomination.valid?
  end

  test "denomination_type should be coin or bill" do
    @denomination.denomination_type = "invalid"
    assert_not @denomination.valid?
    
    @denomination.denomination_type = "coin"
    assert @denomination.valid?
    
    @denomination.denomination_type = "bill"
    assert @denomination.valid?
  end

  # Base denominations do not require year fields; variants carry them
  test "year_introduced is optional on base denomination" do
    @denomination.year_introduced = nil
    assert @denomination.valid?
  end

  test "year_introduced should be greater than zero" do
    @denomination.year_introduced = 0
    assert_not @denomination.valid?
  end

  test "display_name should return formatted name" do
    @denomination.save
    assert_equal "Test Denomination (1.0)", @denomination.display_name
  end

  test "current? should return true when year_discontinued is nil" do
    @denomination.year_discontinued = nil
    assert @denomination.current?
  end

  test "current? should return false when year_discontinued is present" do
    @denomination.year_discontinued = 2023
    assert_not @denomination.current?
  end

  test "coins scope should return only coins" do
    @denomination.save
    bill = CurrencyDenomination.create!(
      currency: @currency,
      name: "Test Bill",
      value: 5.00,
      denomination_type: "bill",
      year_introduced: 2020
    )
    
    assert_includes CurrencyDenomination.coins, @denomination
    assert_not_includes CurrencyDenomination.coins, bill
  end

  test "bills scope should return only bills" do
    @denomination.save
    bill = CurrencyDenomination.create!(
      currency: @currency,
      name: "Test Bill",
      value: 5.00,
      denomination_type: "bill",
      year_introduced: 2020
    )
    
    assert_includes CurrencyDenomination.bills, bill
    assert_not_includes CurrencyDenomination.bills, @denomination
  end
end
