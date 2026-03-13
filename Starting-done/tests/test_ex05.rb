# frozen_string_literal: true

require_relative "test_helper"

class TestEx05 < Minitest::Test
  def test_empty_tokens_print_nothing
    stdout, stderr, status = run_script("ex05/whereto.rb", "Salem , ,Alabama")

    assert status.success?
    assert_equal "", stderr
    assert_equal "", stdout
  end

  def test_valid_query_formats_each_line
    stdout, stderr, status = run_script("ex05/whereto.rb", "Salem,Alabama,Toto,MontGOmery")

    assert status.success?
    assert_equal "", stderr
    assert_equal <<~OUT, stdout
      Salem is the capital of Oregon (akr: OR)
      Montgomery is the capital of Alabama (akr: AL)
      Toto is neither a capital city nor a state
      Montgomery is the capital of Alabama (akr: AL)
    OUT
  end
end
