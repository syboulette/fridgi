class FridgesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_fridge, only: [:show, :edit, :update, :destroy]

  def show
    @list = List.find_by(id: params[:id])
    authorize @fridge
    @fridge_ingredients = @fridge.fridge_ingredients
    @fridge_ingredient = FridgeIngredient.new
    @ingredient = Ingredient.new
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Fridge not found."
    redirect_to root_path
  end

  private

  def fridge_params
    params.require(:fridge).permit(:name, :fridge_ingredients)
  end

  def set_fridge
    @fridge = Fridge.find_by(id: params[:id])
  end
end