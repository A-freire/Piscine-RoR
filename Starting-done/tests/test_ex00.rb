# frozen_string_literal: true

require_relative "test_helper"

class TestEx00 < Minitest::Test
  def test_var_output
    stdout, stderr, status = run_script("ex00/var.rb")

    assert status.success?
    assert_equal "", stderr
    assert_equal <<~OUT, stdout
      mes variables :
      a contient : 10 et est de type: Fixnum
      b contient : 10 et est de type: String
      c contient : nil et est de type: NilClass
      d contient : 10.0 et est de type: Float
    OUT
  end
end
