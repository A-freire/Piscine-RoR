#!/usr/bin/env ruby
$VERBOSE = true

require 'test/unit'
require_relative 'ex04'

class Ex04Test < Test::Unit::TestCase
  def test_subject_example_render
    html = Html.new([
      Head.new([Title.new('Hello ground!')]),
      Body.new([
        H1.new('Oh no, not again!'),
        Img.new([], { src: 'http://i.imgur.com/pfp3T.jpg' })
      ])
    ])

    expected = "<Html>\n<Head>\n<Title>Hello ground!</Title>\n</Head>\n<Body>\n<H1>Oh no, not again!</H1>\n<Img src='http://i.imgur.com/pfp3T.jpg' />\n</Body>\n</Html>"
    assert_equal(expected, html.to_s)
  end

  def test_simple_tag_render
    assert_equal("<Br />", Br.new.to_s)
    assert_equal("<Img src='x' />", Img.new([], { src: 'x' }).to_s)
  end

  def test_text_normalization_for_double_tags
    assert_equal('<P>hello</P>', P.new('hello').to_s)
    assert_equal('<Span>a</Span>', Span.new('a').to_s)
  end
end

