Rails.application.routes.draw do
  devise_for :users, path: 'users', controllers: {
    registrations: 'users/registrations'
  }

  root to: "pages#home"

  resources :users, only: [:show]

  get '/recipes/user_recipes', to: 'recipes#user_recipes'

  resources :recipes do
    resources :recipe_ingredients, only: [:edit, :update]
  end
  resources :recipe do
    post 'recipes/add_recipe_ingredient_to_list', to: 'recipes#add_recipe_ingredient_to_list', as: 'add_recipe_ingredient_to_list_recipes'
  end
  resources :recipe_ingredients, only: [:new, :create, :destroy]
  resources :favorite_recipes, only: [:new, :create, :edit, :index]

  resources :lists do
    resources :list_ingredients, only: [:new, :create, :edit, :update, :destroy] 
  end 
  resources :lists do
    post 'lists/copy_to_fridge', to: 'lists#copy_to_fridge', as: 'copy_to_fridge_lists'
  end
  
  resources :fridges, only: [:show] do
    resources :fridge_ingredients, only: [:new, :create, :edit, :update]
  end
  resources :fridge_ingredients, only: [:destroy]

  resources :ingredients, only: [:create, :edit, :update]
end
