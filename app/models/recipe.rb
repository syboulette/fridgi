class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :dietary_information_recipes
  has_many :reviews
  accepts_nested_attributes_for :recipe_ingredients
  validates_presence_of :title, :total_time, :instruction
  has_one_attached :image
  has_many :users, through: :favourite_recipes
  has_many :favourite_recipes #It can be handle by the policy to only allow the owner to see/edit
  has_many :users, through: :favourite_recipes

  include PgSearch::Model

  pg_search_scope :search_by_title_and_instruction,
                  against: [ :title, :instruction ],
                  associated_against: {
                  user: [ :first_name ]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }
end
