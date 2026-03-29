Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  devise_for :users

  root "products#index"

  resources :brands
  resources :products

  resource :cart, only: %i[show destroy]
  resources :cart_items, only: %i[create destroy] do
    member do
      patch :increment
      patch :decrement
    end
  end

  resource :checkout, controller: :orders, only: %i[show create]
end
