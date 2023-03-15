class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  def index
    @lists = policy_scope(List).all
  end

  def show
    authorize @list
    @list_ingredients = @list.list_ingredients
    @new_ingredient = Ingredient.new
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

  private

  def list_params
    params.require(:list).permit(:name, :list_ingredients)
  end

  def set_list
    @list = List.find_by(id: params[:id])
  end
end