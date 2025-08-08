require "test_helper"

class CurrenciesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @currency = Currency.create!(
      name: "Test Currency",
      code: "TEST",
      country: "Test Country",
      is_active: true
    )
  end

  test "should get index" do
    get currencies_url
    assert_response :success
    assert_not_nil assigns(:currencies)
  end

  test "index shows only active currencies" do
    active = Currency.create!(name: "Active Curr", code: "ACTV", country: "X", is_active: true)
    inactive = Currency.create!(name: "Inactive Curr", code: "INAC", country: "X", is_active: false)

    get currencies_url
    assert_response :success

    names = assigns(:currencies).map(&:name)
    assert_includes names, active.name
    assert_includes names, @currency.name
    assert_not_includes names, inactive.name
  end

  test "should get show" do
    get currency_url(@currency)
    assert_response :success
    assert_equal @currency, assigns(:currency)
  end

  test "show groups denominations into coins and bills" do
    coin = CurrencyDenomination.create!(
      currency: @currency,
      name: "Coin A",
      value: 1.0,
      denomination_type: "coin",
      year_introduced: 2000,
      is_active: true
    )

    bill = CurrencyDenomination.create!(
      currency: @currency,
      name: "Bill A",
      value: 1.0,
      denomination_type: "bill",
      year_introduced: 2000,
      is_active: true
    )

    get currency_url(@currency)
    assert_response :success

    assert_includes assigns(:coin_denominations), coin
    assert_not_includes assigns(:coin_denominations), bill

    assert_includes assigns(:bill_denominations), bill
    assert_not_includes assigns(:bill_denominations), coin
  end
end
