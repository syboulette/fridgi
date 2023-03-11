class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipe = policy_scope(Recipe).all

    if params[:query].present?
      @recipe = Recipe.Recipe_search(params[:query])
    else
      @recipe = Recipe.all
    end
  end

  def new
    @recipe = Recipe.new
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

  def show
    authorize @recipe
  end

  def destroy
    authorize @recipe

    @recipe.destroy
    redirect_to root_path, status: :see_other, notice: "The recipe has been deleted!"
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :instruction, :total_time, :serving, :recipe_ingredients)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
