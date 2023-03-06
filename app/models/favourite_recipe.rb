class FavouriteRecipe < ApplicationRecord
  belongs_to :recipe_id
  belongs_to :user_id
end
