#!/usr/bin/env -S ruby -w

def sample_data
   [
    ['Caleb' , 24],
    ['Calixte' , 84],
    ['Calliste', 65],
    ['Calvin' , 12],
    ['Cameron' , 54],
    ['Camil' , 32],
    ['Camille' , 5],
    ['Can' , 52],
    ['Caner' , 56],
    ['Cantin' , 4],
    ['Carl' , 1],
    ['Carlito' , 23],
    ['Carlo' , 19],
    ['Carlos' , 26],
    ['Carter' , 54],
    ['Casey' , 2]
  ]
end

def grouped_by_age(data)
  grouped = {}
  data.each do |name, age|
    grouped[age] ||= []
    grouped[age] << name
  end
  # puts "grouped : #{grouped.class.to_s}"
  grouped
end

def print_grouped_data
  grouped_by_age(sample_data).each do |age, names|
    puts "#{age} : #{names.join(', ')}"
  end
end

print_grouped_data
