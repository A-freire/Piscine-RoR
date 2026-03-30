Rails.application.routes.draw do
  resources :users
  resources :cuicuis
  resources :comments
  resources :likes

  root "users#index"
end
