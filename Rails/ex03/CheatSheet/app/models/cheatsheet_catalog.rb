require "yaml"

# Loads the cheat sheet content and the navigation tree from YAML.
class CheatsheetCatalog
  PAGE_SLUGS = %w[
    convention
    console
    ruby
    ruby-concepts
    ruby-numbers
    ruby-strings
    ruby-arrays
    ruby-hashes
    rails-folder-structure
    rails-commands
    rails-erb
    editor
    help
  ].freeze

  NAVIGATION = [
    { "title" => "Convention", "slug" => "convention" },
    { "title" => "Console", "slug" => "console" },
    {
      "title" => "Ruby",
      "slug" => "ruby",
      "children" => [
        { "title" => "General Concepts", "slug" => "ruby-concepts" },
        { "title" => "Numbers", "slug" => "ruby-numbers" },
        { "title" => "Strings", "slug" => "ruby-strings" },
        { "title" => "Arrays", "slug" => "ruby-arrays" },
        { "title" => "Hashes", "slug" => "ruby-hashes" }
      ]
    },
    {
      "title" => "Rails",
      "slug" => "rails-folder-structure",
      "children" => [
        { "title" => "Folder Structure", "slug" => "rails-folder-structure" },
        { "title" => "Commands", "slug" => "rails-commands" },
        { "title" => "ERB", "slug" => "rails-erb" }
      ]
    },
    { "title" => "Editor", "slug" => "editor" },
    { "title" => "Help", "slug" => "help" }
  ].freeze

  class << self
    def navigation
      NAVIGATION
    end

    def page(slug)
      pages.fetch(slug)
    end

    def quick_search_commands
      PAGE_SLUGS.each_with_object([]) do |slug, commands|
        commands.concat(commands_for(slug))
      end
    end

    private

    def commands_for(slug)
      page_data = page(slug)

      Array(page_data["commands"]).map do |command|
        command.merge("section" => page_data.fetch("title"))
      end
    end

    def pages
      @pages ||= YAML.safe_load_file(Rails.root.join("config/cheatsheet_pages.yml")).fetch("pages")
    end
  end
end
