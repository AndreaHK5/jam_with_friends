JamWithFriends::Application.routes.draw do
  resources :instruments

  resources :generes

  devise_for :users
  root "home#index"
end
