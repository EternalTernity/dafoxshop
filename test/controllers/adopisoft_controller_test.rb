require "test_helper"

class AdopisoftControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get adopisoft_index_url
    assert_response :success
  end
end
