<<<<<<< HEAD
class ListPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
=======
class ListsPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
>>>>>>> master
  end
end
