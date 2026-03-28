# Taillste

Educational gem for the Ruby on Rails piscine TDD exercise.

## Purpose

`Taillste` provides three rhythm-oriented classes:

- `Taillste::Drum`
- `Taillste::Beat_box`
- `Taillste::Clap`

The behavior of each class is defined by the provided minitest suite.

## Usage

```ruby
require "taillste"

drum = Taillste::Drum.new
drum.beat
# => [1, 4, 9]

drum.count
# => "1\n.\n.\n4\n.\n.\n.\n.\n9\n"
```

## Development

Install dependencies with:

```bash
bundle install
```

Run the test suite with:

```bash
bundle exec rake
```

Build the gem with:

```bash
gem build taillste.gemspec
```

## License

The gem is available as open source under the terms of the MIT License.
