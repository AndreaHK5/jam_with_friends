JamWithFriends::Application.routes.draw do
  get "jam_managements/show", to: 'jam_managements#show', as: "jam_managements_show" 
  get "registrations/after_sign_up_path_for"
  root "home#index"
  get "search/index", to: 'search#index', as: "search"
  get "jam_managements/edit_candidates", to: 'jam_managements#edit_candidates', as: "edit_candidates"
  get "jam_managements/update_candidates", to: 'jam_managements#update_candidates', as: "update_candidates"
  resources :instruments
  resources :genres
  devise_for :users, :controllers => { :registrations => "registrations", :passwords => "passwords"  }
  resources :profile, only: [:show, :edit, :update]
  resources :messages
  resources :conversations
  resources :jams
end
