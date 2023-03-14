class List < ApplicationRecord
  belongs_to :user
  has_many :list_ingredients
  has_many :ingredients, through: :list_ingredients
end
