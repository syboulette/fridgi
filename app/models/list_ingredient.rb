class ListIngredient < ApplicationRecord
  belongs_to :ingredient
  belongs_to :list
  attr_accessible :ingredient_id, :quantity, :unit
end
