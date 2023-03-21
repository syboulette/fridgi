class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: [:show, :edit, :update, :destroy, :bulk_update]

  def index
    @lists = policy_scope(List).all
  end

  def show
    authorize @list
    @list_ingredients = @list.list_ingredients
    @list_ingredient = ListIngredient.new

  end

  def new
    @list = List.new
    authorize @list
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user

    authorize @list

    if @list.save
      redirect_to lists_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @list
    @list.destroy
    redirect_to lists_path, status: :see_other, notice: "The list has been deleted!"
    end

  def edit
    authorize @list
  end

  def update
    authorize @list
    if @list.update(list_params)
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def bulk_update
    skip_authorization
    @list_ingredient = ListIngredient.new
    @ingredient = @list_ingredient.ingredient
    @selected_list_ingredients = ListIngredient.where(id: params.fetch(:list_ingredient_ids, []).compact)
    if params[:commit] == 'bought'
      @selected_list_ingredients.each do |si|
        fridge_ingredient = FridgeIngredient.new(fridge_ingredient_params)
        fridge_ingredient.create(quantity: list_ingredient.quantity, quantity: list_ingredient.quantity)
      end
      selected_list_ingredients.destroy_all
      flash[:notice] = "#{@selected_list_ingredients.count} list_ingredients marked as #{params[:commit]}"
      redirect_to list_path(@list_ingredient.list)
    else
      redirect_to root_path
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