require "test_helper"

class PrivilegesFlowTest < ActionDispatch::IntegrationTest
  test "a user with 2 points can upvote another user's post" do
    sign_in_as(users(:bob2))

    assert_difference("Vote.count", 1) do
      post post_votes_path(posts(:alice_tip)), params: { value: 1 }
    end

    assert_redirected_to post_path(posts(:alice_tip))
  end

  test "a user with 4 points can downvote another user's post" do
    sign_in_as(users(:stephan))

    assert_difference("Vote.count", 1) do
      post post_votes_path(posts(:alice_tip)), params: { value: -1 }
    end
  end

  test "a user with 10 points can edit another user's post" do
    sign_in_as(users(:mentor))

    patch post_path(posts(:alice_tip)), params: {
      post: {
        title: "Cool Coffee Faster",
        content: "Use a wide mug and stir with a cold spoon."
      }
    }

    assert_redirected_to post_path(posts(:alice_tip))
    assert_equal "Cool Coffee Faster", posts(:alice_tip).reload.title
  end

  test "a rookie cannot upvote without enough points" do
    sign_in_as(users(:rookie))

    assert_no_difference("Vote.count") do
      post post_votes_path(posts(:alice_tip)), params: { value: 1 }
    end

    assert_redirected_to post_path(posts(:alice_tip))
  end
end
