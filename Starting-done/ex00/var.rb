#!/usr/bin/env -S ruby -w

def legacy_type_name(value)
  class_name = value.class.to_s
  return "Fixnum" if class_name == "Integer"

  class_name
end

def my_var
  a = 10
  b = "10"
  c = nil
  d = 10.0

  puts "mes variables :"
  puts "a contient : #{a} et est de type: #{legacy_type_name(a)}"
  puts "b contient : #{b} et est de type: #{legacy_type_name(b)}"
  puts "c contient : #{c.inspect} et est de type: #{legacy_type_name(c)}"
  puts "d contient : #{d} et est de type: #{legacy_type_name(d)}"
end

my_var
