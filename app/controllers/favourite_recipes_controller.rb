class FavouriteRecipesController < ApplicationController
  before_action :authenticate_user!, only: :create

  def index
    @favourite_recipes = policy_scope(current_user.favourite_recipes)
  end

  def create
    @favourite_recipe = FavouriteRecipe.new(favourite_recipe_params)
    @favourite_recipe.user = current_user
    authorize @favourite_recipe
    if @favourite_recipe.save!
      redirect_to recipe_path(Recipe.find(params[:recipe_id]))
      flash[:notice] = "Recipe was saved"
    else
      redirect_to recipes_path
      flash[:alert] = "Recipe not saved"
    end
  end

  private

  def favourite_recipe_params
    params.permit(:recipe_id)
  end
end
