require "test_helper"

class CurrencyDenominationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @currency = Currency.create!(
      name: "Test Currency",
      code: "TEST",
      country: "Test Country"
    )
    @denomination = CurrencyDenomination.create!(
      currency: @currency,
      name: "Test Denomination",
      value: 1.00,
      denomination_type: "coin",
      year_introduced: 2020
    )
  end

  test "should get index" do
    get currency_currency_denominations_url(@currency)
    assert_response :success
    assert_equal @currency, assigns(:currency)
  end

  test "should get show" do
    get currency_currency_denomination_path(@currency, @denomination)
    assert_response :success
    assert_equal @denomination, assigns(:denomination)
  end
end
