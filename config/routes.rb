# frozen_string_literal: true

Rails.application.routes.draw do
  resources :reviews
  resources :books, only: %i[create show]  
  resource :users, only: %i[create index]

  get '/profile', to: 'users#user_profile'
  post 'authenticate', to: 'auth#authenticate'
  get '/reviews/get_reviews_for_book/:id', to: 'reviews#get_reviews_for_book'
  get '/books_paginated(/:page)', to: 'books#index'
end
