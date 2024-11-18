require "test_helper"

class VisaCategoryControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get visa_category_new_url
    assert_response :success
  end
end
