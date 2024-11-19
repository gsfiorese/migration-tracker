require "test_helper"

class VisasControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get visas_new_url
    assert_response :success
  end
end
