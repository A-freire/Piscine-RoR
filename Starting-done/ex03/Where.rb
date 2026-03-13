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

def print_capital_for(state_name)
  acronym = states[state_name]
  if acronym.nil?
    puts "Unknown state"
  else
    puts capitals_cities[acronym]
  end
end

def main
  return unless ARGV.length == 1

  print_capital_for(ARGV[0])
end

main
