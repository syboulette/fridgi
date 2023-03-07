class RecipesController < ApplicationController


  def new
    @recipe = Recipe.new
    authorize @recipe
  end

  def create
    @recipe = recipe.new(recipe_params)
    @recipe.user = current_user

    authorize @recipe

    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render :new, status: :unprocessable_entity
    end
  end

end
