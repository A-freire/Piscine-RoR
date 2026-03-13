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

def normalized(text)
  text.strip.downcase
end

def state_lookup_map
  lookup = {}
  states.each do |state_name, acronym|
    lookup[normalized(state_name)] = [state_name, acronym]
  end
  lookup
end

def capital_lookup_map
  lookup = {}
  capitals_cities.each do |acronym, city|
    state_name = states.key(acronym)
    lookup[normalized(city)] = [city, state_name, acronym]
  end
  lookup
end

def has_empty_token?(query)
  query.split(",").any? { |token| token.strip.empty? }
end

def message_for(token, state_lookup, capital_lookup)
  trimmed = token.strip
  key = normalized(trimmed)

  if capital_lookup.key?(key)
    city, state_name, acronym = capital_lookup[key]
    return "#{city} is the capital of #{state_name} (akr: #{acronym})"
  end

  if state_lookup.key?(key)
    state_name, acronym = state_lookup[key]
    city = capitals_cities[acronym]
    return "#{city} is the capital of #{state_name} (akr: #{acronym})"
  end

  "#{trimmed} is neither a capital city nor a state"
end

def main
  return unless ARGV.length == 1

  query = ARGV[0]
  return if has_empty_token?(query)

  state_lookup = state_lookup_map
  capital_lookup = capital_lookup_map

  messages = query.split(",").map do |token|
    message_for(token, state_lookup, capital_lookup)
  end

  puts messages.join("\n")
end

main
