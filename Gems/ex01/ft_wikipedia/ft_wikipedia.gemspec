# frozen_string_literal: true

require_relative "lib/ft_wikipedia/version"

Gem::Specification.new do |spec|
  spec.name = "ft_wikipedia"
  spec.version = FtWikipediaGem::VERSION
  spec.authors = ["Adrien Freire"]
  spec.email = ["afreire-@student.42.fr"]

  spec.summary = "Educational gem to follow first links to philosophy on Wikipedia."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.files = Dir["lib/**/*.rb", "Rakefile", "README.md", "LICENSE.txt"]
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", ">= 1.14"
end
