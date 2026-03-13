#!/usr/bin/env ruby
$VERBOSE = true

require 'test/unit'
require_relative 'ex00'

class Ex00Test < Test::Unit::TestCase
  def setup
    @name = "ex00_test_#{Process.pid}_#{rand(1_000_000)}"
    @file = "#{@name}.html"
  end

  def teardown
    File.delete(@file) if File.exist?(@file)
  end

  def test_initialize_creates_header_and_body
    page = Html.new(@name)
    assert_equal(@name, page.page_name)
    assert(File.exist?(@file))
    content = File.read(@file)
    assert(content.include?('<!DOCTYPE html>'))
    assert(content.include?('<html>'))
    assert(content.include?('<head>'))
    assert(content.include?("<title>#{@name}</title>"))
    assert(content.include?('<body>'))
  end

  def test_dump_and_finish_write_lines
    page = Html.new(@name)
    page.dump('line_1')
    page.dump('line_2')
    page.finish

    lines = File.readlines(@file, chomp: true)
    assert_equal('<p>line_1</p>', lines[-3])
    assert_equal('<p>line_2</p>', lines[-2])
    assert_equal('</body>', lines[-1])
  end
end

