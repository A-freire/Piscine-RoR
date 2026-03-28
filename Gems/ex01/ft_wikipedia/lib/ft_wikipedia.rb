# frozen_string_literal: true

require "nokogiri"
require "open-uri"
require_relative "ft_wikipedia/version"

module Ft_wikipedia
  BASE = "https://en.wikipedia.org"
  PHILOSOPHY_URL = "#{BASE}/wiki/Philosophy"

  class << self
    def search(query, resolver: method(:resolve_title_url), fetcher: method(:fetch_html))
      current_url = resolver.call(query)
      puts "First search @ :#{current_url}"

      visited = {}
      steps = 0

      loop do
        return steps if current_url == PHILOSOPHY_URL

        raise StandardError, "Loop detected there is no way to philosophy here" if visited[current_url]

        visited[current_url] = true
        next_url = next_article_url(fetcher.call(current_url))
        raise StandardError, "Dead end page reached" if next_url.nil?

        puts next_url
        steps += 1
        current_url = next_url
      end
    rescue StandardError => e
      puts e.message
      nil
    end

    def resolve_title_url(query)
      cleaned = query.to_s.strip.tr(" ", "_")
      "#{BASE}/wiki/#{cleaned}"
    end

    def fetch_html(url)
      URI.open(url, "User-Agent" => "Mozilla/5.0").read
    end

    def next_article_url(html)
      doc = Nokogiri::HTML(html)
      paragraph = doc.css("#mw-content-text .mw-parser-output > p").find do |p|
        !p.text.strip.empty?
      end
      return nil unless paragraph

      paragraph.css("a").each do |link|
        href = link["href"]
        next unless valid_article_href?(href)

        return "#{BASE}#{href}"
      end

      nil
    end

    def valid_article_href?(href)
      return false if href.nil? || href.empty?
      return false unless href.start_with?("/wiki/")
      return false if href.include?(":")
      return false if href.include?("#")

      true
    end
  end
end
