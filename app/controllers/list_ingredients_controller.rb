class ListIngredientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list_ingredient, only: [:show, :edit, :update, :destroy]

  def show
    authorize @list_ingredient
  end

  def create
    @list_ingredient = ListIngredient.new(list_ingredient_params)
    @ingredient = Ingredient.new(ingredient_params)
    @list_ingredient.list = List.find(params[:list_id])
    @list_ingredient.ingredient = @ingredient
    authorize @ingredient
    authorize @list_ingredient
    if @ingredient.save! && @list_ingredient.save!
      redirect_to list_path(@list_ingredient.list)
    else
      render "lists/show", status: :unprocessable_entity
    end
  end

  def destroy
    authorize @list_ingredient
    @list_ingredient.destroy
    redirect_to list_path(@list_ingredient.list), status: :see_other, notice: "The ingredient has been deleted!"
  end

  def edit
    @list = List.find(params[:list_id])
    authorize @list_ingredient
  end

  def update
    @ingredient = @list_ingredient.ingredient
    authorize @list_ingredient

    if @list_ingredient.update!(list_ingredient_params) && @ingredient.update!(ingredient_params)
      redirect_to list_path(@list_ingredient.list)
    else
      render "lists/show", status: :unprocessable_entity
    end
  end

  def bulk_update
    @selected_list_ingredients = ListIngredient.where(id: params.fetch(:ids, []).compact)
    @fridge_ingredient = FridgeIngredient.new(@selected_list_ingredient_params)
    authorize @list_ingredient
    authorize @fridge_ingredient
    if @fridge_ingredient.save!
      @selected_list_ingredient.destroy
    else
      redirect_to list_path(@list_ingredient.list)
    end
    flash[:notice] = "#{@selected_list_ingredients.count} list_ingredients marked as #{params[:commit]}"
    redirect_to list_path(@list_ingredient.list)
  end

  private

  def list_ingredient_params
    params.require(:list_ingredient).permit(:quantity, :unit)
  end
  def selected_list_ingredient_params
    params.require(:list_ingredient).permit(:quantity, :unit)
  end

  def ingredient_params
    params.require(:list_ingredient).permit(:name)
  end

  def set_selected_list_ingredients
    @selected_list_ingredients = ListIngredient.where(id: params.fetch(:ids, []).compact)
  end

  def set_list_ingredient
    @list_ingredient = ListIngredient.find(params[:id])
  end
end