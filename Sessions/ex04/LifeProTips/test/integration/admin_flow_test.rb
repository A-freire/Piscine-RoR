require "test_helper"

class AdminFlowTest < ActionDispatch::IntegrationTest
  test "an admin can access each administration page" do
    sign_in_as(users(:admin))

    get admin_users_path
    assert_response :success

    get admin_posts_path
    assert_response :success

    get admin_votes_path
    assert_response :success
  end
end
