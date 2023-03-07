Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  
  resources :users, only: [:show]
  resources :fridges, only: [:show, :create, :destroy, :edit]
  resources :recipes, only: [:new, :create, :destroy, :index, :show] do 
    colection do 
      get :my_recipes
    end
    resources :reviews, only: [:new, :create, :destroy, :edit]
  end
  resources :favorite_recipes, only: [:new, :create, :edit, :index]

  resources :lists, only: [:show, :edit, :destroy]
end
