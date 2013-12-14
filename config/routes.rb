JamWithFriends::Application.routes.draw do
  resources :users, only: [:edit, :update]
  get "users/show_profile", to: 'users#show_profile', as: "show_profile"
  get "users/show_map", to: 'users#show_map', as: "show_map"  
  resources :instruments
  resources :generes
  devise_for :users
  root "home#index"
end
