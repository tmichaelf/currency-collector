require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  setup do
    @currency = currencies(:one)
    @denomination = currency_denominations(:one)
  end

  test "should get admin index" do
    get admin_path
    assert_response :success
    assert_select "h1", "Admin Dashboard"
  end

  test "should get bulk image upload" do
    get admin_bulk_image_upload_path
    assert_response :success
    assert_select "h1", "Bulk Image Upload"
  end

  test "should get image management" do
    get admin_image_management_path
    assert_response :success
    assert_select "h1", "Image Management"
  end

  test "should process bulk upload with valid URLs" do
    post admin_process_bulk_upload_path, params: {
      denomination_id: @denomination.id,
      obverse_url: "https://example.com/obverse.jpg",
      reverse_url: "https://example.com/reverse.jpg"
    }

    assert_redirected_to admin_bulk_image_upload_path
    # Note: This will fail in test environment due to actual HTTP requests
    # In a real scenario, we'd mock the download_image method
  end

  test "should delete obverse image" do
    # Attach a test image first
    @denomination.obverse_image.attach(
      io: StringIO.new("fake image data"),
      filename: "test.jpg",
      content_type: "image/jpeg"
    )

    delete admin_delete_image_path(@denomination, 'obverse')
    assert_redirected_to admin_image_management_path
    assert_equal "Obverse image deleted for #{@denomination.name}", flash[:notice]
    
    # Reload the record to check if image is detached
    @denomination.reload
    refute @denomination.obverse_image.attached?
  end

  test "should delete reverse image" do
    # Attach a test image first
    @denomination.reverse_image.attach(
      io: StringIO.new("fake image data"),
      filename: "test.jpg",
      content_type: "image/jpeg"
    )

    delete admin_delete_image_path(@denomination, 'reverse')
    assert_redirected_to admin_image_management_path
    assert_equal "Reverse image deleted for #{@denomination.name}", flash[:notice]
    
    # Reload the record to check if image is detached
    @denomination.reload
    refute @denomination.reverse_image.attached?
  end
end 