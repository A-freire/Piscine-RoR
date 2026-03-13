#!/usr/bin/env ruby
$VERBOSE = true

require 'test/unit'
require_relative 'whereto'

class Ex05Test < Test::Unit::TestCase
  def test_valid_document
    doc = Html.new([
      Head.new([Title.new(Text.new('Hello ground!'))]),
      Body.new([
        H1.new(Text.new('Oh no, not again!')),
        Img.new([], { src: Text.new('http://i.imgur.com/pfp3T.jpg') })
      ])
    ])

    assert_equal(true, Page.new(doc).is_valid?)
  end

  def test_invalid_head_structure
    doc = Html.new([
      Head.new([Meta.new([], { charset: 'utf-8' })]),
      Body.new([H1.new(Text.new('x'))])
    ])
    assert_equal(false, Page.new(doc).is_valid?)
  end

  def test_invalid_ul_without_li
    doc = Html.new([
      Head.new([Title.new(Text.new('x'))]),
      Body.new([Ul.new([])])
    ])
    assert_equal(false, Page.new(doc).is_valid?)
  end

  def test_invalid_tr_mixed_cells
    doc = Html.new([
      Head.new([Title.new(Text.new('x'))]),
      Body.new([Table.new([Tr.new([Th.new(Text.new('h')), Td.new(Text.new('d'))])])])
    ])
    assert_equal(false, Page.new(doc).is_valid?)
  end

  def test_invalid_img_src_type
    doc = Html.new([
      Head.new([Title.new(Text.new('x'))]),
      Body.new([Img.new([], { src: 'not_text_object' })])
    ])
    assert_equal(false, Page.new(doc).is_valid?)
  end
end

