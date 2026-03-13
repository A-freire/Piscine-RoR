# frozen_string_literal: true

require_relative "test_helper"

class TestEx07 < Minitest::Test
  def test_generates_periodic_table_html
    output_file = ROOT.join("ex07/periodic_table.html")
    output_file.delete if output_file.exist?

    stdout, stderr, status = run_script("ex07/elm.rb")

    assert status.success?
    assert_equal "", stdout
    assert_equal "", stderr
    assert output_file.exist?

    html = output_file.read
    assert_includes html, "<table>"
    assert_includes html, "<h4>Hydrogen</h4>"
    assert_includes html, "<li>No: 1</li>"
    assert_includes html, "<li>Symbol: H</li>"
    assert_includes html, "<li>Molar: 1.00794</li>"
    assert_operator html.scan("<tr>").size, :>=, 7
    assert_operator html.scan('class="empty"').size, :>, 0
  end
end
