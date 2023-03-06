class CreateFavouriteRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :favourite_recipes do |t|
      t.references :recipe_id, null: false, foreign_key: true
      t.references :user_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
