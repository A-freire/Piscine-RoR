#!/usr/bin/env ruby
$VERBOSE = true

class Dup_file < StandardError
  attr_reader :filename, :new_filename

  def initialize(filename)
    super("A file named #{filename} already exist!")
    @filename = filename
    @new_filename = filename
  end

  def show_state
    puts "A file named #{@filename} was already there: #{File.expand_path(@filename)}"
  end

  def correct
    loop do
      @new_filename = @new_filename.sub(/\.html\z/, '.new.html')
      break unless File.exist?(@new_filename)
    end
    @new_filename
  end

  def explain
    puts "Appended .new in order to create requested file: #{File.expand_path(@new_filename)}"
  end
end

class Body_closed < StandardError
  def initialize(filename, line_no, line_text, text_to_insert)
    super("Body has already been closed in #{filename}")
    @filename = filename
    @line_no = line_no
    @line_text = line_text
    @text_to_insert = text_to_insert
  end

  def show_state
    puts "In #{@filename} body was closed :"
    puts "> ln :#{@line_no} #{@line_text} : text has been inserted and tag moved at the end of it."
  end

  def correct
    lines = File.readlines(@filename, chomp: true)
    close_idx = lines.index { |l| l.strip == '</body>' }
    return if close_idx.nil?

    lines.delete_at(close_idx)
    lines << "<p>#{@text_to_insert}</p>"
    lines << '</body>'
    File.open(@filename, 'w') { |f| f.puts(lines) }
  end

  def explain
    puts "Body tag moved after inserted text in #{@filename}."
  end
end

class Html
  attr_reader :page_name

  def initialize(page_name)
    @page_name = page_name
    @file_name = "#{@page_name}.html"
    head
  end

  def head
    raise Dup_file, @file_name if File.exist?(@file_name)

    write_header(@file_name)
  rescue Dup_file => e
    e.show_state
    @file_name = e.correct
    e.explain
    write_header(@file_name)
  end

  def dump(text)
    lines = file_lines
    raise "There is no body tag in #{@file_name}" unless lines.any? { |l| l.strip == '<body>' }

    close_idx = lines.index { |l| l.strip == '</body>' }
    if close_idx
      raise Body_closed.new(@file_name, close_idx + 1, lines[close_idx], text)
    end

    File.open(@file_name, 'a') { |f| f.puts "<p>#{text}</p>" }
  rescue Body_closed => e
    e.show_state
    e.correct
    e.explain
  end

  def finish
    raise "#{@file_name} has already been closed." if file_lines.any? { |l| l.strip == '</body>' }

    File.open(@file_name, 'a') { |f| f.puts '</body>' }
  end

  private

  def write_header(target)
    File.open(target, 'w') do |f|
      f.puts '<!DOCTYPE html>'
      f.puts '<html>'
      f.puts '<head>'
      f.puts "<title>#{@page_name}</title>"
      f.puts '</head>'
      f.puts '<body>'
    end
  end

  def file_lines
    File.exist?(@file_name) ? File.readlines(@file_name, chomp: true) : []
  end
end

if $PROGRAM_NAME == __FILE__
  page = Html.new('test_ex02')
  page.dump('first line')
  page.finish
  page.dump('inserted after body close')
end
