JamWithFriends::Application.routes.draw do
  resources :users, only: [:edit, :update, :show]
  resources :instruments

  resources :generes

  devise_for :users
  root "home#index"
end
