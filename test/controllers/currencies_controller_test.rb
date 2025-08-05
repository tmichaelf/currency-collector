require "test_helper"

class CurrenciesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @currency = Currency.create!(
      name: "Test Currency",
      code: "TEST",
      country: "Test Country"
    )
  end

  test "should get index" do
    get currencies_url
    assert_response :success
    assert_not_nil assigns(:currencies)
  end

  test "should get show" do
    get currency_url(@currency)
    assert_response :success
    assert_equal @currency, assigns(:currency)
  end
end
