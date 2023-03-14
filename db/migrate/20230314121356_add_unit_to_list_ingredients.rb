class AddUnitToListIngredients < ActiveRecord::Migration[7.0]
  def change
    add_column :list_ingredients, :unit, :string
  end
end
