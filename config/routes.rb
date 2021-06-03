# frozen_string_literal: true

Rails.application.routes.draw do
  resources :reviews
  resources :books
  resource :users, only: [:create]
  post '/login', to: 'auth#login'
  get '/auto_login', to: 'auth#auto_login'
  get '/user_is_authed', to: 'auth#user_is_authed'
  get '/profile', to: 'users#user_profile'
end
