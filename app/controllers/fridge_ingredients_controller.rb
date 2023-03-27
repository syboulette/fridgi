class FridgeIngredientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_fridge_ingredient, only: [:show, :edit, :update, :destroy]

  def show
    authorize @fridge_ingredient
  end

  def create
    @fridge_ingredient = FridgeIngredient.new(fridge_ingredient_params)
    @ingredient = Ingredient.new(ingredient_params)
    @fridge_ingredient.fridge = Fridge.find(params[:fridge_id])
    @fridge_ingredient.ingredient = @ingredient
    authorize @ingredient
    authorize @fridge_ingredient
    if @ingredient.save! && @fridge_ingredient.save!
      redirect_to fridge_path(@fridge_ingredient.fridge)
    else
      render fridge_path(@fridge_ingredient.fridge), status: :unprocessable_entity
    end
  end

  def destroy
    authorize @fridge_ingredient
    @fridge_ingredient.destroy
    redirect_to fridge_path(@fridge_ingredient.fridge), status: :see_other, notice: "The ingredient has been deleted!"
  end

  def edit
    @fridge = Fridge.find(params[:fridge_id])
    @ingredient = Ingredient.new(ingredient_params)
    authorize @fridge_ingredient
  end

  def update
    @ingredient = @fridge_ingredient.ingredient
    authorize @fridge_ingredient

    if @fridge_ingredient.update!(fridge_ingredient_params) && @ingredient.update!(ingredient_params)
      redirect_to fridge_path(@fridge_ingredient.fridge)
    else
      render "fridges/show", status: :unprocessable_entity
    end
  end

  private

  def fridge_ingredient_params
    params.require(:fridge_ingredient).permit(:quantity, :unit)
  end
  def fridge_params
    params.require(:fridge_ingredient).permit(:name)
  end
  def ingredient_params
    params.require(:fridge_ingredient).permit(:name)
  end

  def set_fridge_ingredient
    @fridge_ingredient = FridgeIngredient.find_by(id: params[:id])
  end
end