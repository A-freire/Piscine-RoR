# frozen_string_literal: true

require "test_helper"

class FtWikipediaTest < Minitest::Test
  HTML_WITH = ->(href) { "<div id='mw-content-text'><div class='mw-parser-output'><p><a href='#{href}'>x</a></p></div></div>" }

  def setup
    @urls = {
      "kiss" => "https://en.wikipedia.org/wiki/Kiss",
      "matter" => "https://en.wikipedia.org/wiki/Matter",
      "effects_of_blue_lights_technology" => "https://en.wikipedia.org/wiki/Effects_of_blue_lights_technology",
      "directory" => "https://en.wikipedia.org/wiki/Directory",
      "problem" => "https://en.wikipedia.org/wiki/Problem",
      "einstein" => "https://en.wikipedia.org/wiki/Einstein"
    }

    @html_map = {
      "https://en.wikipedia.org/wiki/Kiss" => HTML_WITH.call("/wiki/Love"),
      "https://en.wikipedia.org/wiki/Love" => HTML_WITH.call("/wiki/Philosophy"),
      "https://en.wikipedia.org/wiki/Matter" => HTML_WITH.call("/wiki/Atom"),
      "https://en.wikipedia.org/wiki/Atom" => HTML_WITH.call("/wiki/Matter"),
      "https://en.wikipedia.org/wiki/Effects_of_blue_lights_technology" => "<div id='mw-content-text'><div class='mw-parser-output'><p>No links here.</p></div></div>",
      "https://en.wikipedia.org/wiki/Directory" => HTML_WITH.call("/wiki/Organization"),
      "https://en.wikipedia.org/wiki/Organization" => HTML_WITH.call("/wiki/Philosophy"),
      "https://en.wikipedia.org/wiki/Problem" => HTML_WITH.call("/wiki/Philosophy"),
      "https://en.wikipedia.org/wiki/Einstein" => HTML_WITH.call("/wiki/Philosophy")
    }

    @resolver = ->(query) { @urls[query.to_s.downcase] || "https://en.wikipedia.org/wiki/#{query}" }
    @fetcher = ->(url) { @html_map.fetch(url) { raise "Unknown test URL: #{url}" } }
  end

  def test_kiss_reaches_philosophy
    stdout, = capture_io do
      assert_equal 2, Ft_wikipedia.search("kiss", resolver: @resolver, fetcher: @fetcher)
    end
    assert_includes stdout, "https://en.wikipedia.org/wiki/Love"
    assert_includes stdout, "https://en.wikipedia.org/wiki/Philosophy"
  end

  def test_matter_detects_loop
    stdout, = capture_io do
      assert_nil Ft_wikipedia.search("matter", resolver: @resolver, fetcher: @fetcher)
    end
    assert_includes stdout, "Loop detected there is no way to philosophy here"
  end

  def test_effects_detects_dead_end
    stdout, = capture_io do
      assert_nil Ft_wikipedia.search("Effects_of_blue_lights_technology", resolver: @resolver, fetcher: @fetcher)
    end
    assert_includes stdout, "Dead end page reached"
  end

  def test_directory_reaches_philosophy
    assert_equal 2, Ft_wikipedia.search("directory", resolver: @resolver, fetcher: @fetcher)
  end

  def test_problem_reaches_philosophy
    assert_equal 1, Ft_wikipedia.search("problem", resolver: @resolver, fetcher: @fetcher)
  end

  def test_einstein_reaches_philosophy
    assert_equal 1, Ft_wikipedia.search("einstein", resolver: @resolver, fetcher: @fetcher)
  end
end
