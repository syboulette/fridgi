class IngredientPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def move_bought_to_fridge?
    true 
  end

  def create?
    user
  end
  def edit?
    update?
  end
  def update?
    user
  end
end