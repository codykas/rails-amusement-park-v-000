Rails.application.routes.draw do
  resources :users
  root 'users#home'

  resources :attractions, only: [:index, :new, :create, :show, :edit, :update]
  post '/rides/new', to: 'rides#new'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  get '/signout', to: 'sessions#sign_out'
end
