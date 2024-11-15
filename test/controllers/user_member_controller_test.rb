require "test_helper"

class UserMemberControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_member_index_url
    assert_response :success
  end
end
