class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  has_many :dietary_information_recipes

  validates_presence_of :total_time, :title, :serving, :instruction, :recipe_ingredients
end
