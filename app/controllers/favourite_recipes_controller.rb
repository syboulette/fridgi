class FavouriteRecipesController < ApplicationController
  before_action :authenticate_user!, only: :create
  def create
    @favourite_recipe = FavouriteRecipe.new(favourite_recipe_params)
    @recipe = Recipe.find_by_id(params[:recipe_id])
    @favourite_recipe.recipe = @recipe
    @favourite_recipe.user = current_user
    if favourite_recipe.save!
      redirect_to favourite_recipes_path
    else
      redirect_to recipes_path
    end
    authorize @favourite_recipe
  end

  def new
    @favourite_recipe = FavouriteRecipe.new
    authorize @favourite_recipe
  end
  private

  def favourite_recipe_params
    params.require(:favourite_recipe).permit[:user_id, :recipe_id]
  end
end
