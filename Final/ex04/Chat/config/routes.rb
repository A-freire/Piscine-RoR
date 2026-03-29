Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root "chat_rooms#index", as: :authenticated_root
  end

  root "pages#home"

  resources :chat_rooms, only: [:index, :show] do
    resources :messages, only: :create
  end
end
