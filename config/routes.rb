Rails.application.routes.draw do
  resources :users
  resources :profiles
  resources :addresses
  resources :teachers
end
