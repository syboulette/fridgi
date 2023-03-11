Rails.application.routes.draw do
  devise_for :users, path: 'users', controllers: {
    registrations: 'users/registrations'
  } 
  
  root to: "pages#home"
  
  resources :users, only: [:show, :edit]
  resources :fridges, only: [:show, :index, :create, :destroy, :edit]
  resources :recipes, only: [:new, :create, :destroy, :index, :show] do 
    collection do 
      get :my_recipes
    end
    resources :reviews, only: [:new, :create, :destroy, :edit]
  end
  resources :favorite_recipes, only: [:new, :create, :edit, :index]

  resources :lists, only: [:show, :index, :create, :destroy, :edit]
end

