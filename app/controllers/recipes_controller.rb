class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query].present?
      @recipes = policy_scope(Recipe).search_by_title_and_instruction(params[:query])
    else
      @recipes = policy_scope(Recipe).all
    end

    if params[:total_time].present?
      @recipes = @recipes.where(total_time: 0..params[:total_time].to_i)
    end

    if params[:serving].present?
      @recipes = @recipes.where(serving: 0..params[:serving].to_i)
    end

    if params[:difficulty].present?
      @recipes = @recipes.where(difficulty: params[:difficulty].to_i)
    end

    @recipes = @recipes.paginate(page: params[:page], per_page: 20)
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
