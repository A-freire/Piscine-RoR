#!/usr/bin/env -S ruby -w

def parse_line(line)
  pattern = /\A([^=]+)=\s*position:(\d+),\s*number:(\d+),\s*small:\s*([^,]+),\s*molar:([^,]+),\s*electron:(.+)\z/
  match = line.strip.match(pattern)
  return nil if match.nil?

  {
    name: match[1].strip,
    position: match[2].to_i,
    number: match[3].to_i,
    symbol: match[4].strip,
    molar: match[5].strip,
    period: match[6].strip.split.map(&:to_i).length
  }
end

def read_elements(path)
  File.readlines(path).map { |line| parse_line(line) }.compact
end

def build_grid(elements)
  grid = Hash.new { |hash, key| hash[key] = {} }
  elements.each do |element|
    grid[element[:period]][element[:position]] = element
  end
  grid
end

def element_cell_html(element)
  <<~HTML
    <td class="element">
      <h4>#{element[:name]}</h4>
      <ul>
        <li>No: #{element[:number]}</li>
        <li>Symbol: #{element[:symbol]}</li>
        <li>Molar: #{element[:molar]}</li>
      </ul>
    </td>
  HTML
end

def empty_cell_html(colspan = 1)
  if colspan > 1
    "<td class=\"empty\" colspan=\"#{colspan}\"></td>"
  else
    "<td class=\"empty\"></td>"
  end
end

def build_table_rows(grid, max_period)
  rows = []
  (1..max_period).each do |period|
    cells = []
    position = 0
    while position <= 17
      element = grid[period][position]
      if element
        cells << element_cell_html(element)
        position += 1
      else
        start = position
        position += 1
        position += 1 while position <= 17 && grid[period][position].nil?
        cells << empty_cell_html(position - start)
      end
    end
    rows << "<tr>#{cells.join}</tr>"
  end
  rows.join("\n")
end

def build_html(rows)
  <<~HTML
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <title>Periodic Table</title>
      <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { border-collapse: collapse; }
        td { border: none; width: 110px; height: 95px; vertical-align: top; padding: 4px; }
        .element { border: 1px solid #333; }
        h4 { margin: 0 0 4px; font-size: 13px; }
        ul { margin: 0; padding-left: 16px; font-size: 11px; }
        .empty { border: none; padding: 0; }
      </style>
    </head>
    <body>
      <table>
    #{rows}
      </table>
    </body>
    </html>
  HTML
end

def create_periodic_table
  input_path = File.join(__dir__, "periodic_table.txt")
  output_path = File.join(__dir__, "periodic_table.html")

  abort "Error: File not found" unless File.exist?(input_path)
  abort "Error: Not a file" unless File.file?(input_path)
  abort "Error: File not readable" unless File.readable?(input_path)
  
  elements = read_elements(input_path)
  grid = build_grid(elements)
  rows = build_table_rows(grid, elements.map { |element| element[:period] }.max)
  File.write(output_path, build_html(rows))
end

create_periodic_table
