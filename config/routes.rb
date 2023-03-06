Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  
  resources :users, only: [:show]
  resources :fridges, only: [:show, :create, :destroy, :edit]
  resources :recipes, only: [:new, :create, :destroy, :index, :show]
  resources :favorite_recipes, only: [:new, :create, :edit,]
  get "/my_recipes", to: "user#recipes"
  get "/favorite_recipes", to: "user#favorite_recipes"
  resources :reviews, only: [:new, :create, :destroy, :edit]
  resources :lists, only: [:show, :edit, :destroy]
end
