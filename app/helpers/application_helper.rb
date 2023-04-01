module ApplicationHelper
  def ingredients_from_csv
    ingredients = []
    CSV.foreach(Rails.root.join('db', 'updated_ingredients.csv'), headers: true) do |row|
      ingredients << row[0] # Assuming the ingredient name is in the first column
    end
    ingredients
  end
end
