#!/usr/bin/env -S ruby -w

def read_numbers(path)
  abort "Error: File '#{path}' not found" unless File.exist?(path)
  abort "Error: '#{path}' is not a file" unless File.file?(path)
  abort "Error: File '#{path}' is not readable" unless File.readable?(path)
  
  File.read(path).split(",").map(&:strip).map(&:to_i)
  # File.read(path).split(",").map(&:strip).reject(&:empty?).map(&:to_i)
end

def print_sorted_numbers
  numbers = read_numbers(File.join(__dir__, "numbers.txt"))
  numbers.sort.each { |number| puts number }
end

print_sorted_numbers
