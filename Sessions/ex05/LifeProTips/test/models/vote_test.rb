require "test_helper"

class VoteTest < ActiveSupport::TestCase
  test "a regular user cannot vote twice on the same post" do
    vote = Vote.new(user: users(:alice), post: posts(:bob_tip), value: 1)

    assert_not vote.valid?
    assert_includes vote.errors.full_messages, "User has already been taken"
  end

  test "an author cannot vote for their own post" do
    vote = Vote.new(user: users(:alice), post: posts(:alice_tip), value: 1)

    assert_not vote.valid?
    assert_includes vote.errors.full_messages, "You cannot vote for your own post."
  end

  test "an admin can upvote the same post multiple times" do
    assert_difference("Vote.count", 1) do
      Vote.cast_by!(user: users(:admin), post: posts(:mentor_tip), value: 1)
    end
  end
end
