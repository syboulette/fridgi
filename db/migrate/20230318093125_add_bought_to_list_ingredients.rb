class AddBoughtToListIngredients < ActiveRecord::Migration[7.0]
  def change
    add_column :list_ingredients, :bought, :boolean, default: false
  end
end
