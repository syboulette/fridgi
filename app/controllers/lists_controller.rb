class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  def index
    @lists = policy_scope(List)
  end

  def show
    authorize @list
    @list_ingredients = @list.list_ingredients
  end

  def new
    @list = List.new
    @fridge_ingredients = FridgeIngredient.find(params[:fridge_ingredients_id])
    authorize @list
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user
    @fridge_ingredients = FridgeIngredient.find(params[:fridge_ingredient_id])
    @list.fridge_ingredient = @fridge_ingredient

    authorize @list

    if @list.save!
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @list
    @list.destroy
    redirect_to root_path, status: :see_other, notice: "Your booking has been removed"
  end

  private

  def set_list
    @list = List.find_by(user: current_user)
  end
end