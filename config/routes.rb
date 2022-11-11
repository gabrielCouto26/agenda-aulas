Rails.application.routes.draw do
  resources :users
  resources :profiles
  resources :addresses
  resources :teachers
  resources :students
  resources :subjects
  resources :classrooms
end
