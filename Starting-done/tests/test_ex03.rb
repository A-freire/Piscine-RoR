# frozen_string_literal: true

require_relative "test_helper"

class TestEx03 < Minitest::Test
  def test_known_state
    stdout, stderr, status = run_script("ex03/Where.rb", "Oregon")

    assert status.success?
    assert_equal "", stderr
    assert_equal "Salem\n", stdout
  end

  def test_unknown_state
    stdout, stderr, status = run_script("ex03/Where.rb", "toto")

    assert status.success?
    assert_equal "", stderr
    assert_equal "Unknown state\n", stdout
  end

  def test_wrong_arity_prints_nothing
    stdout, stderr, status = run_script("ex03/Where.rb")

    assert status.success?
    assert_equal "", stderr
    assert_equal "", stdout
  end
end
