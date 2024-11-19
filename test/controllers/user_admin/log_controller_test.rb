require "test_helper"

class UserAdmin::LogControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_admin_log_index_url
    assert_response :success
  end
end
