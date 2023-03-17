Rails.application.routes.draw do
  devise_for :users, path: 'users', controllers: {
    registrations: 'users/registrations'
  }

  root to: "pages#home"

  resources :users, only: [:show]

  resources :recipes do
    resources :recipe_ingredients  
  end 

    resources :reviews, only: [:new, :create, :destroy, :edit]
  end
  resources :favorite_recipes, only: [:new, :create, :edit, :index]

  resources :lists do
    resources :list_ingredients, only: [:new, :create, :edit, :update]  
  end 
  resources :list_ingredients, only: [:destroy]

  resources :fridges, only: [:show] do
    resources :fridge_ingredients, only: [:new, :create, :edit, :update]  
  end 
  resources :fridge_ingredients, only: [:destroy]

  resources :ingredients, only: [:create, :edit, :update]
end
