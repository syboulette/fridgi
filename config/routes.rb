Rails.application.routes.draw do
  devise_for :users, path: 'users', controllers: {
    registrations: 'users/registrations'
  }

  root to: "pages#home"

  resources :users, only: [:show]
<<<<<<< HEAD
  resources :fridges, only: [:show, :index, :create, :destroy, :edit]
  resources :recipes, only: [:new, :create, :edit, :destroy, :index, :show] do
    collection do
=======
  get "/my-fridgi", to: "fridges#show", as: :fridge
  resources :fridges, only: [:create, :destroy, :edit]
  resources :recipes, only: [:new, :create, :destroy, :index, :show] do 
    collection do 
>>>>>>> 367b261bc2a39f1263c8fa66814f8956878bd7f8
      get :my_recipes
    end
    resources :reviews, only: [:new, :create, :destroy, :edit]
  end
  resources :favorite_recipes, only: [:new, :create, :edit, :index]

  resources :lists, only: [:show, :edit, :destroy]
end
