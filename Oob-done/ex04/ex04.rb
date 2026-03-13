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

  def initialize(tag, content = [], tag_type = 'double', opt = {})
    @tag = tag.to_s
    @content = normalize_content(content)
    @tag_type = tag_type.to_s
    @opt = normalize_opt(opt)
  end

  def add_content(*nodes)
    nodes.flatten.each { |node| @content << normalize_node(node) }
  end

  def to_s
    return "<#{@tag}#{render_attrs} />" if @tag_type == 'simple'

    if @content.empty?
      "<#{@tag}>\n</#{@tag}>"
    elsif @content.all? { |node| node.is_a?(Text) }
      "<#{@tag}>#{@content.map(&:to_s).join}</#{@tag}>"
    else
      "<#{@tag}>\n#{@content.map(&:to_s).join("\n")}\n</#{@tag}>"
    end
  end

  private

  def normalize_content(content)
    case content
    when Array then content.map { |node| normalize_node(node) }
    when nil then []
    else [normalize_node(content)]
    end
  end

  def normalize_node(node)
    return node if node.is_a?(Elem) || node.is_a?(Text)

    Text.new(node)
  end

  def normalize_opt(opt)
    normalized = {}
    opt.each { |k, v| normalized[k.to_sym] = v }
    normalized
  end

  def render_attrs
    return '' if @opt.empty?

    @opt.map do |k, v|
      value = v.is_a?(Text) ? v.to_s : v
      " #{k}='#{value}'"
    end.join
  end
end

class Html < Elem
  def initialize(content = [], opt = {})
    super('Html', content, 'double', opt)
  end
end
class Head < Elem
  def initialize(content = [], opt = {})
    super('Head', content, 'double', opt)
  end
end
class Body < Elem
  def initialize(content = [], opt = {})
    super('Body', content, 'double', opt)
  end
end
class Title < Elem
  def initialize(content = [], opt = {})
    super('Title', content, 'double', opt)
  end
end
class Meta < Elem
  def initialize(content = [], opt = {})
    super('Meta', content, 'simple', opt)
  end
end
class Img < Elem
  def initialize(content = [], opt = {})
    super('Img', content, 'simple', opt)
  end
end
class Table < Elem
  def initialize(content = [], opt = {})
    super('Table', content, 'double', opt)
  end
end
class Th < Elem
  def initialize(content = [], opt = {})
    super('Th', content, 'double', opt)
  end
end
class Tr < Elem
  def initialize(content = [], opt = {})
    super('Tr', content, 'double', opt)
  end
end
class Td < Elem
  def initialize(content = [], opt = {})
    super('Td', content, 'double', opt)
  end
end
class Ul < Elem
  def initialize(content = [], opt = {})
    super('Ul', content, 'double', opt)
  end
end
class Ol < Elem
  def initialize(content = [], opt = {})
    super('Ol', content, 'double', opt)
  end
end
class Li < Elem
  def initialize(content = [], opt = {})
    super('Li', content, 'double', opt)
  end
end
class H1 < Elem
  def initialize(content = [], opt = {})
    super('H1', content, 'double', opt)
  end
end
class H2 < Elem
  def initialize(content = [], opt = {})
    super('H2', content, 'double', opt)
  end
end
class P < Elem
  def initialize(content = [], opt = {})
    super('P', content, 'double', opt)
  end
end
class Div < Elem
  def initialize(content = [], opt = {})
    super('Div', content, 'double', opt)
  end
end
class Span < Elem
  def initialize(content = [], opt = {})
    super('Span', content, 'double', opt)
  end
end
class Hr < Elem
  def initialize(content = [], opt = {})
    super('Hr', content, 'simple', opt)
  end
end
class Br < Elem
  def initialize(content = [], opt = {})
    super('Br', content, 'simple', opt)
  end
end

if $PROGRAM_NAME == __FILE__
  puts Html.new([
    Head.new([Title.new('Hello ground!')]),
    Body.new([
      H1.new('Oh no, not again!'),
      Img.new([], { src: 'http://i.imgur.com/pfp3T.jpg' })
    ])
  ])
end
