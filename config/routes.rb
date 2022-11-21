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
  resources :subjects do
    get '/classrooms', to: 'subjects#list_classrooms'
  end
  resources :classrooms do
    get '/students', to: 'classrooms#list_students'
  end
  resources :class_details

  post '/login', to: 'auth#login'
  post '/dashboard', to: 'dashboard#index'

  get '/students/user/:user_id', to: 'students#show_by_user'
  get '/teachers/user/:user_id', to: 'teachers#show_by_user'
  get '/class_details/classroom/:classroom_id', to: 'class_details#show_by_classroom'
end
