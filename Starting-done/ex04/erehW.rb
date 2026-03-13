#!/usr/bin/env -S ruby -w

def states
  {
    "Oregon" => "OR",
    "Alabama" => "AL",
    "New Jersey" => "NJ",
    "Colorado" => "CO"
  }
end

def capitals_cities
  {
    "OR" => "Salem",
    "AL" => "Montgomery",
    "NJ" => "Trenton",
    "CO" => "Denver"
  }
end

def print_state_for(capital_city)
  acronym = capitals_cities.key(capital_city)
  if acronym.nil?
    puts "Unknown capital city"
  else
    puts states.key(acronym)
  end
end

def main
  return unless ARGV.length == 1

  print_state_for(ARGV[0])
end

main
