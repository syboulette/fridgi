class IngredientsController < ApplicationController
  before_action :authenticate_user!

  def create
    @ingredient = Ingredient.new(ingredient_params)
    @list = List.find_by(id: params[:ingredient][:list])

    authorize @ingredient

    if @ingredient.save!
      list_ingredient = ListIngredient.new(list: @list, ingredient: @ingredient, quantity: params[:ingredient][:quantity], unit: params[:ingredient][:unit])
      list_ingredient.save!
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name)
  end

end
