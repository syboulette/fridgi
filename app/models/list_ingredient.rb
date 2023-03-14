class ListIngredient < ApplicationRecord
  belongs_to :ingredient
  belongs_to :list
end
