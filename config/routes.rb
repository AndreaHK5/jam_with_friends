JamWithFriends::Application.routes.draw do
  get "search/index", to: 'search#index', as: "search"
  resources :users, only: [:edit, :update]
  get "users/show_profile", to: 'users#show_profile', as: "show_profile"
  get "users/edit_profile", to: 'users#edit_profile', as: "edit_profile"      
  get "users/show_map", to: 'users#show_map', as: "show_map"
  get "users/show_other_profile/:id", to: 'users#show_other_profile', as:"show_other_profile"
  resources :instruments
  resources :generes
  devise_for :users
  root "home#index"
end
