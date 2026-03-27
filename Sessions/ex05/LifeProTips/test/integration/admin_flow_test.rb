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

  test "an admin can delete a user who edited another post" do
    sign_in_as(users(:admin))

    assert_difference("User.count", -1) do
      delete admin_user_path(users(:stephan))
    end

    assert_redirected_to admin_users_path
    assert_nil posts(:alice_tip).reload.last_editor_id
  end
end
