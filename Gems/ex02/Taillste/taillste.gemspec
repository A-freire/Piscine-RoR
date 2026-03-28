# frozen_string_literal: true

require_relative "lib/taillste/version"

Gem::Specification.new do |spec|
  spec.name = "taillste"
  spec.version = Taillste::VERSION
  spec.authors = ["Sannaka"]
  spec.email = ["sannaka@42.fr"]

  spec.summary = "GEM for educational purposes."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.files = Dir["lib/**/*.rb", "Rakefile", "README.md", "LICENSE.txt", "CHANGELOG.md"]
  spec.require_paths = ["lib"]
end
