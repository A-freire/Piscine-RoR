#!/usr/bin/env -S ruby -w

def sample_data
  [
    ["Frank", 33],
    ["Stacy", 15],
    ["Juan", 24],
    ["Dom", 32],
    ["Steve", 24],
    ["Jill", 24]
  ]
end

def print_sorted_names
  sorted_data = sample_data.sort_by { |name, age| [age, name] }
  sorted_data.each { |name, _age| puts name }
end

print_sorted_names
