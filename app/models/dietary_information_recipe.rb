class DietaryInformationRecipe < ApplicationRecord
  belongs_to :dietary_information
  belongs_to :recipe
end
