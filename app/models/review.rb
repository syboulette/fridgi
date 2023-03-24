class Review < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
  validates :content, length: {minimum: 20}
end
