# frozen_string_literal: true

require_relative "lib/deepthought/version"

Gem::Specification.new do |spec|
  spec.name = "deepthought"
  spec.version = DeepthoughtGem::VERSION
  spec.authors = ["Adrien Freire"]
  spec.email = ["afreire-@student.42.fr"]

  spec.summary = "Educational gem that answers the ultimate question."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.files = Dir["lib/**/*.rb", "Rakefile", "README.md", "LICENSE.txt"]
  spec.require_paths = ["lib"]

  spec.add_dependency "colorize", "~> 1.1"
end
