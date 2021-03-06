JamWithFriends::Application.routes.draw do
  get "registrations/after_sign_up_path_for"
  root "home#index"
  get "search/index", to: 'search#index', as: "search"
  resources :instruments
  resources :genres
  devise_for :users, :controllers => { :registrations => "registrations", :passwords => "passwords"  }
  resources :profile, only: [:show, :edit, :update]
  resources :messages
  resources :conversations
end
