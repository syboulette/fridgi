class RecipeIngredientPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  def destroy?
    user
  end
  def edit?
    update?
  end
  def create?
    user
  end
  def update?
    user
  end
end