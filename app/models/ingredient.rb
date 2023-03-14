class Ingredient < ApplicationRecord
  has_many :fridge_ingredients
  has_many :list_ingredients
  attr_accessor :quantity, :unit
end
