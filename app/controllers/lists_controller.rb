class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: [:show, :destroy]

  def show
    authorize @list
    @list_ingredients = @list.list_ingredients
    @list_ingredient = ListIngredient.new
  end

  def copy_to_fridge
    @list = List.find(params[:list_id])
    @list.user = current_user
    fridge = current_user.fridge
    authorize @list
    params[:list_ingredient_ids].each do |list_ingredient_id|
      list_ingredient = ListIngredient.find(list_ingredient_id)
      fridge.fridge_ingredients.create(ingredient_id: list_ingredient.ingredient_id, quantity: list_ingredient.quantity, unit: list_ingredient.unit)
      list_ingredient.destroy
    end

    redirect_to fridge_path(@user.fridge), notice: "Selected ingredients have been added to your fridge."
  end

  private

  def list_params
    params.require(:list).permit(:name, :list_ingredients)
  end
  def fridge_ingredient_params
    params.require(:list).permit(:quantity, :unit)
  end
  def set_list
    @list = List.find_by(id: params[:id])
  end
end