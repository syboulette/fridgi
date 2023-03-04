class FridgeIngredient < ApplicationRecord
  belongs_to :ingredient
  belongs_to :fridge
end
