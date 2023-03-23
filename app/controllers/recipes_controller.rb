class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = policy_scope(Recipe).all
  end

  def user_recipes
    @user_recipes = current_user.recipes
    authorize @user_recipes
  end

  def show
    authorize @recipe
    @recipe_ingredients = @recipe.recipe_ingredients
    @recipe_ingredient = RecipeIngredient.new
  end

  def new
    @recipe = Recipe.new
    @recipe.recipe_ingredients.build
    authorize @recipe
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    authorize @recipe

    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @recipe
    @recipe.destroy
    redirect_to recipes_user_recipes_path, status: :see_other, notice: "The recipe has been deleted!"
  end

  def edit
    authorize @recipe
  end

  def update
    authorize @recipe
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def add_recipe_ingredient_to_list
    @user = user
    list = user.list.last
    authorize @recipe
    missing_ingredients.each do |ingredient| 
      ListIngredient.new(ingredient_id: ingredient.id, quantity: (@recipe_ingredients.find_by(ingredient_id: ingredient.id).quantity - fridge_ingredient.quantity), unit: @recipe_ingredient.unit, list_id: list.id)
    end 
    redirect_to lists_path(list.id), notice: "The missing ingredient have been added to your list!"
  end 


  private

  def recipe_params
    params.require(:recipe).permit(:prep_time, :instruction, :difficulty, :utensil, :title, :cooking_time, :total_time, :serving, recipe_ingredients_attributes: [:ingredient_id, :quantity, :unit])
  end

  def set_recipe
    @recipe = Recipe.find_by(id: params[:id])
  end

end
