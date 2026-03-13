#!/usr/bin/env ruby
$VERBOSE = true

require 'test/unit'
require_relative 'ex01'

class Ex01UnitTest < Test::Unit::TestCase
  def setup
    @name = "ex01_test_#{Process.pid}_#{rand(1_000_000)}"
    @file = "#{@name}.html"
    File.delete(@file) if File.exist?(@file)
  end

  def teardown
    File.delete(@file) if File.exist?(@file)
  end

  def test_duplicate_file_raises
    Html.new(@name)
    error = assert_raise(RuntimeError) { Html.new(@name) }
    assert_equal("#{@file} already exist!", error.message)
  end

  def test_dump_and_finish_return_nil
    page = Html.new(@name)
    assert_nil(page.dump('hello'))
    assert_nil(page.finish)
  end

  def test_finish_twice_raises
    page = Html.new(@name)
    page.finish
    error = assert_raise(RuntimeError) { page.finish }
    assert_equal("#{@file} has already been closed", error.message)
  end

  def test_dump_without_body_raises
    page = Html.new(@name)
    File.write(@file, "<html>\n<head></head>\n")
    error = assert_raise(RuntimeError) { page.dump('x') }
    assert_equal("There is no body tag in #{@file}", error.message)
  end

  def test_dump_after_closed_body_raises
    page = Html.new(@name)
    page.finish
    error = assert_raise(RuntimeError) { page.dump('x') }
    assert_equal("Body has already been closed in #{@file}", error.message)
  end
end

