class CreateDietaryInformationRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :dietary_information_recipes do |t|
      t.references :dietary_information, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
