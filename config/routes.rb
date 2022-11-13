Rails.application.routes.draw do
  resources :users
  resources :profiles
  resources :addresses
  resources :teachers
  resources :students do
    resources :classrooms, only: [:index, :create, :destroy]
  end
  resources :subjects
  resources :classrooms
  resources :class_details
end
