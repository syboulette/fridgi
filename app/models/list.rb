class List < ApplicationRecord
  belongs_to :user
  has_many :list_ingredient
  has_many :ingredient, through: :list_ingredient
end
