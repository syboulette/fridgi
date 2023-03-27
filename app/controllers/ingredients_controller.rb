class IngredientsController < ApplicationController
    ingredient = Ingredient.includes(list_ingredient: :list).all)
    ingredient = Ingredient.includes(fridge_ingredient: :fridge).all)
