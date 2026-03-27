require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "points unlock the expected privileges" do
    assert_equal 2, users(:bob2).points
    assert users(:bob2).can_upvote_posts?
    assert_not users(:bob2).can_downvote_posts?

    assert_equal 4, users(:stephan).points
    assert users(:stephan).can_downvote_posts?

    assert_equal 10, users(:mentor).points
    assert users(:mentor).can_edit_other_posts?

    assert_equal ["No specific rights"], users(:rookie).privilege_labels
  end
end
