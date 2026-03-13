# frozen_string_literal: true

require_relative "test_helper"

class TestEx06 < Minitest::Test
  def test_names_sorted_by_age_then_name
    stdout, stderr, status = run_script("ex06/CoffeeCroissant.rb")

    assert status.success?
    assert_equal "", stderr
    assert_equal <<~OUT, stdout
      Stacy
      Jill
      Juan
      Steve
      Dom
      Frank
    OUT
  end
end
