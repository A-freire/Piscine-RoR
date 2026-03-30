# Renders the multi-page cheat sheet and the quick search table.
class PagesController < ApplicationController
  def show
    current_page = params.fetch(:page, "convention")
    navigation = navigation_for(current_page)

    @navigation = navigation.items
    @page = navigation.page(CheatsheetCatalog.page(current_page))
  end

  def quick_search
    @navigation = navigation_for("quick-search").items
    @records = CheatsheetCatalog.quick_search_commands
  end

  private

  def navigation_for(current_page)
    CheatsheetNavigation.new(
      current_page: current_page,
      page_paths: page_paths,
      extra_items: extra_navigation_items
    )
  end

  def extra_navigation_items
    [{ "title" => "Quick search", "slug" => "quick-search", "path" => quick_search_path }]
  end

  def page_paths
    CheatsheetCatalog::PAGE_SLUGS.each_with_object({}) do |slug, paths|
      paths[slug] = slug == "convention" ? root_path : cheatsheet_page_path(page: slug)
    end
  end
end
