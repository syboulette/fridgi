class Review < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
  validates :comment, length: {minimum: 20}
end
