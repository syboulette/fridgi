class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

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

  private

  def recipe_params
    params.require(:recipe).permit(:title, :instruction, :total_time, :serving)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
