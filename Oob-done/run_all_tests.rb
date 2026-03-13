#!/usr/bin/env ruby
$VERBOSE = true

tests = [
  'ex00/ex00_test.rb',
  'ex01/ex01_test.rb',
  'ex01/ex01_unit_test.rb',
  'ex02/ex02_test.rb',
  'ex03/ex03_test.rb',
  'ex04/ex04_test.rb',
  'ex05/ex05_test.rb'
]

base = File.expand_path(__dir__)
failed = []

tests.each do |rel_path|
  abs_path = File.join(base, rel_path)
  puts "\n===== Running #{rel_path} ====="
  ok = system('ruby', abs_path)
  failed << rel_path unless ok
end

puts "\n===== Summary ====="
if failed.empty?
  puts 'All tests passed.'
  exit 0
else
  puts "Failed tests: #{failed.join(', ')}"
  exit 1
end

