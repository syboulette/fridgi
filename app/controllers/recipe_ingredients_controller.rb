class RecipeIngredientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe_ingredient, only: [:show, :edit, :update, :destroy]

  def index
    @recipe_ingredients = policy_scope(RecipeIngredient).all
  end

  def show
    authorize @recipe_ingredient
  end

  def create
    @recipe_ingredient = RecipeIngredient.new(recipe_ingredient_params)
    @ingredient = Ingredient.new(ingredient_params)
    @recipe_ingredient.recipe = Recipe.find(params[:recipe_id])
    @recipe_ingredient.ingredient = @ingredient
    authorize @ingredient
    authorize @recipe_ingredient
    if @ingredient.save! && @recipe_ingredient.save!
      redirect_to recipe_path(@recipe_ingredient.recipe), notice: "The ingredient has been created!"
    else
      render "recipes/show", status: :unprocessable_entity
    end
  end

  def destroy
    authorize @recipe_ingredient
    @recipe_ingredient.destroy
    redirect_to recipe_path(@recipe_ingredient.recipe), status: :see_other, notice: "The ingredient has been deleted!"
  end

  def edit
    @recipe = Recipe.find(params[:recipe_id])
    authorize @recipe_ingredient
  end

  def update
    @ingredient = @recipe_ingredient.ingredient
    authorize @recipe_ingredient

    if @recipe_ingredient.update!(recipe_ingredient_params) && @ingredient.update!(ingredient_params)
      redirect_to recipe_path(@recipe_ingredient.recipe)
    else
      render "recipes/show", status: :unprocessable_entity
    end
  end

  private

  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(:quantity, :unit)
  end

  def ingredient_params
    params.require(:recipe_ingredient).permit(:name)
  end

  def set_recipe_ingredient
    @recipe_ingredient = RecipeIngredient.find_by(id: params[:id])
  end
end