class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :dietary_information_recipes
  accepts_nested_attributes_for :recipe_ingredients

  validates_presence_of :title, :total_time, :instruction

  has_one_attached :image
end
