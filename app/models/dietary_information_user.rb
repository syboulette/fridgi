class DietaryInformationUser < ApplicationRecord
  belongs_to :user
  belongs_to :dietary_information
end
