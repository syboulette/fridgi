class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :fridge, dependent: :destroy
  has_one :list, dependent: :destroy
  has_many :recipes
  has_one_attached :avatar
  has_many :reviews
  # validates :phone_number, format: { with: /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/ }
  has_many :favourite_recipes
  has_many :favourited_recipes, through: :favourite_recipes, source: :recipe
end
