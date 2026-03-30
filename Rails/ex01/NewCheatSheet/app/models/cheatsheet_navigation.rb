# Builds the navigation structure consumed by the cheat sheet layout and pages.
class CheatsheetNavigation
  def initialize(current_page:, page_paths:, extra_items: [])
    @current_page = current_page
    @page_paths = page_paths
    @configured_extra_items = extra_items
  end

  def items
    primary_items + extra_items
  end

  def page(page_data)
    page_data.merge("children" => decorate_children(Array(page_data["children"])))
  end

  private

  attr_reader :configured_extra_items, :current_page, :page_paths

  def primary_items
    CheatsheetCatalog.navigation.map { |item| build_item(item) }
  end

  def build_item(item)
    slug = item.fetch("slug")
    children = decorate_children(Array(item["children"]))

    item.merge(
      "path" => page_paths.fetch(slug),
      "children" => children,
      "active" => active?(slug) || children.any? { |child| child.fetch("active") }
    )
  end

  def decorate_children(children)
    children.map { |child| build_child(child) }
  end

  def build_child(child)
    slug = child.fetch("slug")

    child.merge(
      "path" => page_paths.fetch(slug),
      "active" => active?(slug)
    )
  end

  def extra_items
    configured_extra_items.map do |item|
      item.merge("active" => active?(item.fetch("slug")))
    end
  end

  def active?(slug)
    current_page == slug
  end
end
