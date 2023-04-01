class IngredientsController < ApplicationController
    ingredient = Ingredient.includes(list_ingredient: :list).all
    ingredient = Ingredient.includes(fridge_ingredient: :fridge).all
end
def search
    @ingredients = Ingredient.where('name ILIKE ?', "%#{params[:q]}%")
    render json: @ingredients.pluck(:name, :id)
end
