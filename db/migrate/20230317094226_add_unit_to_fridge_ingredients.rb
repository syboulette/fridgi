class AddUnitToFridgeIngredients < ActiveRecord::Migration[7.0]
  def change
    add_column :fridge_ingredients, :unit, :string
  end
end
