class ListIngredientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list_ingredient, only: [:show, :edit, :update, :destroy]

  def index
    @list_ingredients = policy_scope(ListIngredients_Ingredient).all
  end

  def show
    authorize @list_ingredient
  end

  def new
    @list_ingredient = ListIngredients.new
    authorize @list_ingredient
  end

  def create
    @list_ingredient = ListIngredients.new(list_ingredient_params)
    @list_ingredient.user = current_user

    authorize @list_ingredient

    if @list_ingredient.save
      redirect_to list_ingredients_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @list_ingredient
    @list_ingredient.destroy
    redirect_to list_path(@list_ingredient.list), status: :see_other, notice: "The ingredient has been deleted!"
  end

  def edit
    authorize @list_ingredient
  end

  def update
    authorize @list_ingredient
    if @list_ingredient.update(list_ingredient_params)
      redirect_to list_ingredient_path(@list_ingredient)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def list_ingredient_params
    params.require(:ingredient_id, :list_id, :quantity, :unit).permit(:quantity, :unit, :ingredient_id, :list_id)
  end

  def set_list_ingredient
    @list_ingredient = ListIngredient.find_by(id: params[:id])
  end
end