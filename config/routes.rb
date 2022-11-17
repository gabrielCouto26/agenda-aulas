Rails.application.routes.draw do
  resources :users
  resources :profiles
  resources :addresses
  resources :teachers do
    resources :classrooms, only: [:index, :create, :destroy]
  end
  resources :students do
    resources :classrooms, only: [:index, :create, :destroy]
  end
  resources :subjects
  resources :classrooms
  resources :class_details

  post '/login', to: 'auth#login'
  post '/dashboard', to: 'dashboard#index'

  get '/students/user/:user_id', to: 'students#show_by_user'
end
