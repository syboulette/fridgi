class FavouriteRecipesController < ApplicationController
  before_action :authenticate_user!, only: :create

  def index
    @favourite_recipes = policy_scope(current_user.favourite_recipes)
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @favourite_recipe = FavouriteRecipe.new
    @favourite_recipe.recipe = @recipe
    @favourite_recipe.user = current_user
    authorize @favourite_recipe

    @favourite_recipe.save ? flash[:notice] = "Recipe was saved" : flash[:alert] = "Recipe not saved"
    redirect_to recipes_path
  end

  def destroy
    @favourite_recipe = FavouriteRecipe.find(params[:id])
    authorize @favourite_recipe
    @favourite_recipe.destroy
    redirect_to recipes_path, status: :see_other, notice: "The recipe has been removed from favourites!"
  end

  def favourited
    @favourite_recipe = Recipe.find(params[:id])
    @favourited = @favourite_recipe.favourite_recipes.exists?(user: current_user)
  end

  private

  def favourite_recipe_params
    params.permit(:recipe_id)
  end
end
