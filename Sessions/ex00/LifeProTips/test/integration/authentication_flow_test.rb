require "test_helper"

class AuthenticationFlowTest < ActionDispatch::IntegrationTest
  test "a visitor is redirected when trying to read a post" do
    get post_path(posts(:alice_tip))

    assert_redirected_to root_path
    follow_redirect!
    assert_match "You need an account to see this", response.body
  end

  test "a user can register and is automatically logged in" do
    assert_difference("User.count", 1) do
      post sign_in_path, params: {
        user: {
          name: "newbie",
          email: "newbie@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end

    assert_redirected_to root_path
    follow_redirect!
    assert_match "Welcome newbie", response.body
    assert_match "Log_out", response.body
  end
end
