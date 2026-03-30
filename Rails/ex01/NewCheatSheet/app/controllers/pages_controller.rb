# Renders the multi-page cheat sheet required for exercise 01.
class PagesController < ApplicationController
  def show
    current_page = params.fetch(:page, "convention")
    navigation = navigation_for(current_page)

    @navigation = navigation.items
    @page = navigation.page(CheatsheetCatalog.page(current_page))
  end

  private

  def navigation_for(current_page)
    CheatsheetNavigation.new(current_page: current_page, page_paths: page_paths)
  end

  def page_paths
    CheatsheetCatalog::PAGE_SLUGS.each_with_object({}) do |slug, paths|
      paths[slug] = slug == "convention" ? root_path : cheatsheet_page_path(page: slug)
    end
  end
end
