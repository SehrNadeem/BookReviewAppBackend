Rails.application.routes.draw do
  resources :reviews
  resources :books
  resources :users
  post '/login', to: 'auth#create'
          get '/current_user', to: 'auth#show'
          post '/sign_up', to: 'users#create'
end
