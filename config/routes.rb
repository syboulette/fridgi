Rails.application.routes.draw do
  devise_for :users, path: 'users', controllers: {
    registrations: 'users/registrations'
  }

  root to: "pages#home"

  resources :users, only: [:show]

  get '/recipes/user_recipes', to: 'recipes#user_recipes'

  resources :recipes do
    resources :recipe_ingredients, only: [:edit, :update]
    resources :favourite_recipes, only: [:create]
    resources :reviews, only: [:new, :create, :show]
  end

  resources :reviews, only: [:destroy, :edit, :update]

  resources :recipe_ingredients, only: [:new, :create, :destroy]

  resources :favourite_recipes, only: [:edit, :index, :destroy]

  resources :lists, only: [:show] do
    resources :list_ingredients, only: [:new, :create, :edit, :update]
  end
  
  resources :list_ingredients, only: [:destroy]

  resources :lists, only: [:show] do
    post 'lists/copy_to_fridge', to: 'lists#copy_to_fridge', as: 'copy_to_fridge_lists'
  end

  resources :fridges, only: [:show] do
    resources :fridge_ingredients, only: [:new, :create, :edit, :update]
  end

  resources :fridge_ingredients, only: [:destroy]

  resources :ingredients do
    collection do
      get 'search'
    end
  end
end
