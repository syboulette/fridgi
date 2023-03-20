class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = policy_scope(Recipe).all
    @favourite_recipe = FavouriteRecipe.new
  end

  def show
    authorize @recipe
    @recipe_ingredients = @recipe.recipe_ingredients
    @recipe_ingredient = RecipeIngredient.new

  end

  def new
    @recipe = Recipe.new
    @recipe_ingredient = RecipeIngredient.new
    authorize @recipe
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    @recipe_ingredient = RecipeIngredient.new(recipe_ingredient_params)
    @ingredient = Ingredient.new(ingredient_params)
    @recipe_ingredient.recipe = Recipe.find(params[:recipe_id])
    @recipe_ingredient.ingredient = @ingredient
    authorize @ingredient
    authorize @recipe_ingredient
    if @recipe.save! && @ingredient.save! && @recipe_ingredient.save!
      render "recipes/show"
    else
      render "recipes/show", status: :unprocessable_entity
    end
    authorize @recipe
  end

  def destroy
    authorize @recipe
    @recipe.destroy
    redirect_to recipes_path, status: :see_other, notice: "The recipe has been deleted!"
    end

  def edit
    authorize @recipe
  end

  def update
    authorize @recipe
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:recipe_ingredients, :prep_time, :instruction, :difficulty, :utensil, :title, :cooking_time, :total_time, :serving)
  end

  def set_recipe
    @recipe = Recipe.find_by(id: params[:id])
  end
end
