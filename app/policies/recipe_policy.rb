class RecipePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    create?
  end

  def create?
    user
  end

  def show?
    user
  end

  def edit?
    update?
  end

  def update?
    user
  end

  def user_recipes?
    user
  end

  def destroy?
    user
  end

  def add_recipe_ingredient_to_list?
    user = @user
  end

  def remove_recipe_ingredient_from_fridge?
    user = @user
  end
end
