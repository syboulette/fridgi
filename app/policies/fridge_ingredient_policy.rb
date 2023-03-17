class FridgeIngredientPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
  
  def show?
    user
  end

  def create?
    user
  end

  def destroy?
    user
  end

  def edit?
    update?
  end

  def update?
    user
  end
end