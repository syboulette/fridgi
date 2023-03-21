class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  # validates_presence_of :total_time, :title, :serving, :instruction, :recipe_ingredients
  has_many :users, through: :favourite_recipes
  has_many :favourite_recipes #It can be handle by the policy to only allow the owner to see/edit
end
