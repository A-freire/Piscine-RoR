#!/usr/bin/env ruby
$VERBOSE = true

class Html
  attr_reader :page_name

  def initialize(page_name)
    @page_name = page_name
    head
  end

  def head
    raise "#{file_name} already exist!" if File.exist?(file_name)

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
    content = file_content
    raise "There is no body tag in #{file_name}" unless content.include?('<body>')
    raise "Body has already been closed in #{file_name}" if content.include?('</body>')

    File.open(file_name, 'a') { |f| f.write "<p>#{text}</p>\n" }
    nil
  end

  def finish
    raise "#{file_name} has already been closed" if file_content.include?('</body>')

    File.open(file_name, 'a') { |f| f.write "</body>" }
    nil
  end

  private

  def file_name
    "#{@page_name}.html"
  end

  def file_content
    File.exist?(file_name) ? File.read(file_name) : ''
  end
end

if $PROGRAM_NAME == __FILE__
  page = Html.new('test_ex01')
  page.dump('hello')
  page.finish
end
