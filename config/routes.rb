Rails.application.routes.draw do
  devise_for :users, path: 'users', controllers: {
    registrations: 'users/registrations'
  }

  root to: "pages#home"

  resources :users, only: [:show]
  get "/my-fridgi", to: "fridges#show", as: :fridge
  resources :fridges, only: [:create, :destroy, :edit]
  resources :recipes, only: [:new, :create, :destroy, :index, :show] do
    collection do
      get :my_recipes
    end
    resources :reviews, only: [:new, :create, :destroy, :edit]
  end
  resources :favorite_recipes, only: [:new, :create, :edit, :index]

  resources :lists do
    resources :list_ingredients, only: [:new, :create, :edit, :update]  
  end 
  resources :list_ingredients, only: [:destroy]
  resources :ingredients, only: [:create, :edit, :update]
end
