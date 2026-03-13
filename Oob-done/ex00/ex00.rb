#!/usr/bin/env ruby
$VERBOSE = true

class Html
  attr_reader :page_name

  def initialize(page_name)
    @page_name = page_name
    head
  end

  def head
    File.open(file_name, 'w') do |f|
      f.write "<!DOCTYPE html>\n"
      f.write "<html>\n"
      f.write "<head>\n"
      f.write "<title>#{@page_name}</title>\n"
      f.write "</head>\n"
      f.write "<body>\n"
    end
  end

  def dump(text)
    File.open(file_name, 'a') { |f| f.write "<p>#{text}</p>\n" }
  end

  def finish
    File.open(file_name, 'a') { |f| f.write "</body>" }
  end

  private

  def file_name
    "#{@page_name}.html"
  end
end

if $PROGRAM_NAME == __FILE__
  page = Html.new('test')
  3.times { |i| page.dump("line_#{i}") }
  page.finish
end
