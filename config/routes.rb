JamWithFriends::Application.routes.draw do
  root "home#index"
  get "search/index", to: 'search#index', as: "search"
  resources :instruments
  resources :generes
  devise_for :users
  resources :profile, only: [:show, :edit, :update]
end
