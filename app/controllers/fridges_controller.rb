class FridgesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_fridge, only: [:show, :edit, :update, :destroy]

  def show
    authorize @fridge
    @fridge_ingredients = @fridge.fridge_ingredients
    @fridge_ingredient = FridgeIngredient.new
  end

  private

  def fridge_params
    params.require(:fridge).permit(:name, :fridge_ingredients)
  end

  def set_fridge
    @fridge = Fridge.find_by(id: params[:id])
  end
end