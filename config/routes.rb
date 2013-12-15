JamWithFriends::Application.routes.draw do
  resources :users, only: [:show, :edit, :update]
  get "users/show_map", to: 'users#show_map', as: "show_map"  
  resources :instruments
  resources :generes
  devise_for :users
  root "home#index"
end
