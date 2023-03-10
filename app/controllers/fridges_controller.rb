class FridgesController < ApplicationController
  before_action :set_fridge

  def show
    authorize @fridge
    
    @fridge_ingredients = @fridge.fridge_ingredients
  end

  def edit

  end

  def add

  end

  private
  
  def set_fridge
    @fridge = Fridge.find_by(user: current_user)
  end

end
