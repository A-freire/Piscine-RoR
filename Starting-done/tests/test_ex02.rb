# frozen_string_literal: true

require_relative "test_helper"

class TestEx02 < Minitest::Test
  def test_h2o_groups_names_by_age
    stdout, stderr, status = run_script("ex02/H2o.rb")

    assert status.success?
    assert_equal "", stderr

    lines = stdout.lines.map(&:strip).reject(&:empty?)

    assert_includes lines, "24 : Caleb"
    assert_includes lines, "54 : Cameron, Carter"
    assert_includes lines, "2 : Casey"
    assert_equal 15, lines.size
  end
end
