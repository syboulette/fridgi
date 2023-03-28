class ListPolicy < ApplicationPolicy
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

  def destroy?
    user
  end

  def copy_to_fridge?
    user = @user
  end
end
