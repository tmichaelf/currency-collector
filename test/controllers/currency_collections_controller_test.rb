require "test_helper"

class CurrencyCollectionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(
      email: "test@example.com",
      username: "testuser",
      first_name: "Test",
      last_name: "User"
    )
    
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
    
    @collection = CurrencyCollection.create!(
      user: @user,
      currency_denomination: @denomination,
      quantity: 1,
      condition: "mint",
      acquired_date: Date.current
    )
  end

  test "should get index" do
    get currency_collections_url
    assert_response :success
    assert_not_nil assigns(:collections)
  end

  test "should get show" do
    get currency_collection_url(@collection)
    assert_response :success
    assert_equal @collection, assigns(:collection)
  end

  test "should get new" do
    get new_currency_collection_url
    assert_response :success
    assert_not_nil assigns(:collection)
  end

  test "should create collection" do
    assert_difference('CurrencyCollection.count') do
      post currency_collections_url, params: {
        currency_collection: {
          currency_denomination_id: @denomination.id,
          quantity: 2,
          condition: "excellent",
          acquired_date: Date.current,
          notes: "Test notes"
        }
      }
    end

    assert_redirected_to currency_collection_url(CurrencyCollection.last)
  end

  test "should get edit" do
    get edit_currency_collection_url(@collection)
    assert_response :success
    assert_equal @collection, assigns(:collection)
  end

  test "should update collection" do
    patch currency_collection_url(@collection), params: {
      currency_collection: {
        quantity: 3,
        condition: "very_good"
      }
    }
    assert_redirected_to currency_collection_url(@collection)
    @collection.reload
    assert_equal 3, @collection.quantity
    assert_equal "very_good", @collection.condition
  end

  test "should destroy collection" do
    assert_difference('CurrencyCollection.count', -1) do
      delete currency_collection_url(@collection)
    end

    assert_redirected_to currency_collections_url
  end
end
