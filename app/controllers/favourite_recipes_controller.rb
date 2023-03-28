class FavouriteRecipesController < ApplicationController
  before_action :authenticate_user!, only: :create

  def index
    @favourite_recipes = policy_scope(current_user.favourite_recipes)
  end

  def create
    @favourite_recipe = FavouriteRecipe.new(favourite_recipe_params)
    @favourite_recipe.user = current_user
    authorize @favourite_recipe
    if @favourite_recipe.save
      @favourite_recipe = FavouriteRecipe.find_by(user: current_user, recipe_id: @favourite_recipe.recipe_id)
      redirect_to recipe_path(Recipe.find(params[:recipe_id]))
      flash[:notice] = "Recipe was saved"
    else
      redirect_to recipes_path
      flash[:alert] = "Recipe not saved"
    end
  end

  def destroy
    @favourite_recipe = FavouriteRecipe.find(params[:id])
    authorize @favourite_recipe
    @favourite_recipe.destroy
    redirect_to favourite_recipes_path(@favourite_recipe.recipe_id), status: :see_other, notice: "The recipe has been removed from favourites!"
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
