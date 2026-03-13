#!/usr/bin/env ruby
$VERBOSE = true

require 'test/unit'
require_relative 'ex02'

class Ex02Test < Test::Unit::TestCase
  def setup
    @base = "ex02_test_#{Process.pid}_#{rand(1_000_000)}"
    @main = "#{@base}.html"
    @new = "#{@base}.new.html"
    @new2 = "#{@base}.new.new.html"
  end

  def teardown
    [@main, @new, @new2].each do |file|
      File.delete(file) if File.exist?(file)
    end
  end

  def test_duplicate_filename_creates_new_file
    File.write(@main, 'existing')
    Html.new(@base)
    assert(File.exist?(@new), 'Should create .new.html file')
  end

  def test_dump_after_closed_body_moves_tag_and_inserts_text
    page = Html.new(@base)
    page.dump('first')
    page.finish
    page.dump('second')

    lines = File.readlines(@main, chomp: true)
    assert_equal('<p>second</p>', lines[-2])
    assert_equal('</body>', lines[-1])
    assert_equal(1, lines.count { |l| l.strip == '</body>' })
  end

  def test_finish_twice_raises
    page = Html.new(@base)
    page.finish
    error = assert_raise(RuntimeError) { page.finish }
    assert_equal("#{@main} has already been closed.", error.message)
  end
end

