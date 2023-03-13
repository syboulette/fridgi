require "open-uri"
require "csv"

start = Time.now

puts "=== DESTROYING TABLES ==="

User.destroy_all
puts "User destroyed"

Ingredient.destroy_all
puts "Ingredient destroyed"

#############################################
# Ingredient
#############################################

filepath = "db/updated_ingredients.csv"

CSV.foreach(filepath, headers: :first_row) do |row|
  # API search here for nutrient score
  # save nutriscore to a variable like score
  # You might need a condition to not create an Ingredient without a nutriscore, unless a nutriscore is not required
  Ingredient.create!(name: row['ingredient']) #nutriscore: score
end

#############################################
# Recipe
#############################################

#############################################
# User
#############################################
<<<<<<< HEAD


puts "#{user.first_name} #{user.last_name} added to the users"
=======
>>>>>>> e745923b2ee6a9af8e80534bb19a884c240468e6
