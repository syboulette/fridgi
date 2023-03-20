class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  validates_presence_of :total_time, :title, :serving, :instruction, :recipe_ingredients
  has_many :users, through: :favorite_recipes
  has_many :favorite_recipes
end
