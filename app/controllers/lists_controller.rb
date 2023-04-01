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
    list_ingredient_ids = params[:ids].split(",").map(&:to_i)
    if list_ingredient_ids.present?
      list_ingredients = @list.list_ingredients.where(id: list_ingredient_ids)
      list_ingredients.each do |list_ingredient|
        fridge.fridge_ingredients.create(
          ingredient_id: list_ingredient.ingredient_id,
          quantity: list_ingredient.quantity,
          unit: list_ingredient.unit
        )
        list_ingredient.destroy
      end
      redirect_to fridge_path(current_user.fridge), notice: "The ingredients are now in your fridge."
    else
      redirect_to @list, alert: "Select at least one ingredient to put into your fridge."
    end
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
