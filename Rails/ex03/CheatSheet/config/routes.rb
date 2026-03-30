Rails.application.routes.draw do
  root "pages#show", defaults: { page: "convention" }
  get "quick_search", to: "pages#quick_search"
  get "log_book", to: "pages#log_book"
  post "log_book", to: "pages#create_log_entry"

  get ":page", to: "pages#show", as: :cheatsheet_page,
    constraints: {
      page: /convention|console|ruby|ruby-concepts|ruby-numbers|ruby-strings|ruby-arrays|ruby-hashes|rails-folder-structure|rails-commands|rails-erb|editor|help/
    }

  get "up" => "rails/health#show", as: :rails_health_check
end
