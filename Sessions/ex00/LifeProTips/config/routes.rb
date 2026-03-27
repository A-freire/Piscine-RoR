Rails.application.routes.draw do
  namespace :admin do
    resources :users, only: %i[index edit update destroy]
    resources :posts, only: %i[index edit update destroy]
    resources :votes, only: %i[index destroy]
  end

  get "sign_in", to: "users#new"
  post "sign_in", to: "users#create"
  get "log_in", to: "sessions#new"
  post "log_in", to: "sessions#create"
  delete "log_out", to: "sessions#destroy"

  resources :users, only: %i[show edit update]
  resources :posts do
    resources :votes, only: :create
  end

  root "posts#index"
end
