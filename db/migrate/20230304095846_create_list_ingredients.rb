class CreateListIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :list_ingredients do |t|
      t.references :ingredient, null: false, foreign_key: true
      t.references :list, null: false, foreign_key: true
      t.integer :quantity
      t.timestamps
    end
  end
end
