class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :dietary_information_recipes
  has_many :reviews
  accepts_nested_attributes_for :recipe_ingredients
  validates_presence_of :title, :total_time, :instruction

  has_one_attached :image
  has_many :users, through: :favourite_recipes
  has_many :favourite_recipes #It can be handle by the policy to only allow the owner to see/edit
end
