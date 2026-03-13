# frozen_string_literal: true

require_relative "test_helper"

class TestEx04 < Minitest::Test
  def test_known_capital
    stdout, stderr, status = run_script("ex04/erehW.rb", "Salem")

    assert status.success?
    assert_equal "", stderr
    assert_equal "Oregon\n", stdout
  end

  def test_unknown_capital
    stdout, stderr, status = run_script("ex04/erehW.rb", "toto")

    assert status.success?
    assert_equal "", stderr
    assert_equal "Unknown capital city\n", stdout
  end

  def test_no_argument_prints_nothing
    stdout, stderr, status = run_script("ex04/erehW.rb")

    assert status.success?
    assert_equal "", stderr
    assert_equal "", stdout
  end
end
