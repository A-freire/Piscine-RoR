#!/usr/bin/env ruby
$VERBOSE = true

class Text
  attr_reader :text

  def initialize(text)
    @text = text.to_s
  end

  def to_s
    @text
  end
end

class Elem
  attr_reader :tag, :content, :tag_type, :opt

  def initialize(tag = '', content = [], tag_type = 'double', opt = {})
    @tag = tag.to_s
    @content = content
    @tag_type = tag_type.to_s
    @opt = normalize_opt(opt)
  end

  def add_content(*nodes)
    @content = [] unless @content.is_a?(Array)
    nodes.flatten.each do |node|
      next unless node.is_a?(Elem) || node.is_a?(Text)

      @content << node
    end
  end

  def to_s
    "\"#{render}\""
  end

  protected

  def render
    if @tag_type == 'simple'
      attrs = render_attrs
      return "<#{@tag}#{attrs} />"
    end

    if @content.is_a?(Array)
      if @content.empty?
        "<#{@tag}>\\n</#{@tag}>"
      else
        inner = @content.map { |node| node.is_a?(Elem) ? node.render : node.to_s }.join('\\n')
        "<#{@tag}>\\n#{inner}\\n</#{@tag}>"
      end
    else
      "<#{@tag}>#{@content}</#{@tag}>"
    end
  end

  private

  def normalize_opt(opt)
    normalized = {}
    opt.each { |k, v| normalized[k.to_sym] = v }
    normalized
  end

  def render_attrs
    return '' if @opt.empty?

    @opt.map { |k, v| " #{k}='#{v}'" }.join
  end
end

if $PROGRAM_NAME == __FILE__
  body = Elem.new('body')
  h1 = Elem.new('h1', Text.new('"Oh no, not again!"'))
  body.add_content(h1)
  puts body
end
