class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query].present?
      @recipes = policy_scope(Recipe).search_by_title_and_instruction(params[:query])
    else
      @recipes = policy_scope(Recipe).all
    end
  end

  def user_recipes
    @user_recipes = current_user.recipes
    authorize @user_recipes
  end

  def show
    authorize @recipe
    @recipe_ingredients = @recipe.recipe_ingredients
    @recipe_ingredient = RecipeIngredient.new
    @review = Review.new
    @favourite_recipe = FavouriteRecipe.new
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
    user = current_user
    list = user.list.last
    @recipe = Recipe.find_by(id: params[:recipe_id])
    authorize @recipe
    @recipe_ingredients = @recipe.recipe_ingredients
    @recipe_ingredient = RecipeIngredient.new
    missing_ingredients = []
  
    # Iterate through the recipe ingredients and check if they are in the list
    @recipe_ingredients.each do |recipe_ingredient|
      list_ingredient = ListIngredient.find_by(ingredient_id: recipe_ingredient.ingredient_id, list_id: list.id)
  
      if list_ingredient.nil?
        # If the ingredient is not in the list, create a new list ingredient with quantity 0
        list_ingredient = ListIngredient.create(ingredient_id: recipe_ingredient.ingredient_id, quantity: 0, list_id: list.id)
      end
  
      if list_ingredient.quantity < recipe_ingredient.quantity
        # If the list ingredient quantity is less than the recipe ingredient quantity, add the missing ingredient to the list
        missing_ingredients << Ingredient.find(recipe_ingredient.ingredient_id)
      end
    end
  
    # Add the missing ingredients to the list
    missing_ingredients.each do |ingredient|
      recipe_ingredient = @recipe_ingredients.find_by(ingredient_id: ingredient.id)
      list_ingredient = ListIngredient.find_by(ingredient_id: ingredient.id, list_id: list.id)
      ListIngredient.create(ingredient_id: ingredient.id, quantity: recipe_ingredient.quantity - list_ingredient.quantity, unit: recipe_ingredient.unit, list_id: list.id)
    end 
  
    redirect_to lists_path(list.id), notice: "The missing ingredient have been added to your list!"
  end
   

  def remove_recipe_ingredient_from_fridge
    @user = user
    fridge = user.fridge
    @recipe = Recipe.find_by(id: params[:recipe_id])
    authorize @recipe
    recipe_ingredients.each do |ingredient| 
      ListIngredient.new(ingredient_id: ingredient.id, quantity: (@recipe_ingredients.find_by(ingredient_id: ingredient.id).quantity - fridge_ingredient.quantity), unit: @recipe_ingredient.unit, list_id: list.id)
    end 
    redirect_to lists_path(list.id), notice: "The missing ingredient have been added to your list!"
  end 


  private

  def recipe_params
    params.require(:recipe).permit(:image, :prep_time, :instruction, :difficulty, :utensil, :title, :cooking_time, :total_time, :serving, recipe_ingredients_attributes: [:ingredient_id, :quantity, :unit])
  end

  def set_recipe
    @recipe = Recipe.find_by(id: params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
