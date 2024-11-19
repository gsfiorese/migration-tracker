require "test_helper"

class UserAdmin::WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_admin_welcome_index_url
    assert_response :success
  end
end
