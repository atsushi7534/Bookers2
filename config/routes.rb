Rails.application.routes.draw do
  root 'homes#index'
  get "home/about" => "homes#about"


  devise_for :users

  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:index, :show, :edit, :update]
end