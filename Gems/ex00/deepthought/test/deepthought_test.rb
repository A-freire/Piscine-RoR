# frozen_string_literal: true

require "test_helper"

class DeepthoughtTest < Minitest::Test
  def test_new_returns_deepthought_object
    assert_instance_of Deepthought, Deepthought.new
  end

  def test_respond_returns_42_for_ultimate_question
    result = capture_io do
      assert_equal "42", Deepthought.new.respond("The Ultimate Question of Life, the Universe and Everything")
    end
    assert_includes result.first, "42"
  end

  def test_respond_returns_bored_for_other_questions
    result = capture_io do
      assert_equal "Mmmm i'm bored", Deepthought.new.respond("Hello")
    end
    assert_includes result.first, "Mmmm i'm bored"
  end
end
