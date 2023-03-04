class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.time :prep_time
      t.string :instruction
      t.integer :difficulty
      t.string :utensil
      t.string :title
      t.time :cooking_time
      t.time :total_time
      t.integer :serving
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
