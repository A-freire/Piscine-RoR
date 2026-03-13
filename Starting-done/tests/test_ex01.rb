# frozen_string_literal: true

require_relative "test_helper"

class TestEx01 < Minitest::Test
  def test_numbers_are_printed_sorted_one_per_line
    stdout, stderr, status = run_script("ex01/croissant.rb")

    assert status.success?
    assert_equal "", stderr

    printed = stdout.lines.map(&:strip).reject(&:empty?).map(&:to_i)
    source = ROOT.join("ex01/numbers.txt").read.split(",").map(&:strip).reject(&:empty?).map(&:to_i)

    assert_equal source.sort, printed
  end
end
