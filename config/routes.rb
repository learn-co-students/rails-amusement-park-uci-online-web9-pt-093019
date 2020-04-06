Rails.application.routes.draw do
  resources :rides
  resources :users
  resources :attractions
  root 'static#home'
  get '/signin', to: 'sessions#new'
  post '/session', to: 'sessions#create'
  get '/session', to: 'sessions#destroy'
end
