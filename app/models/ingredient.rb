class Ingredient < ApplicationRecord
  has_many :fridge_ingredients
  has_many :liste_ingredients
end
