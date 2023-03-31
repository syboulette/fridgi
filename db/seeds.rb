require "open-uri"
require "csv"
require 'unsplash'

start = Time.now

puts "=== DESTROYING TABLES ==="

User.destroy_all
puts "User destroyed"

Ingredient.destroy_all
puts "Ingredient destroyed"

#############################################
# Ingredient
#############################################

filepath = "db/ingredients.csv"

CSV.foreach(filepath, headers: :first_row) do |row|
  # API search here for nutrient score
  # save nutriscore to a variable like score
  # You might need a condition to not create an Ingredient without a nutriscore, unless a nutriscore is not required
  Ingredient.create!(name: row['IngredientNameEN']) # nutriscore: score
end

puts "=== INGREDIENT SEEDED ==="



puts "=== START SEEDING UNIT ==="

filepath2 = "db/units.csv"

CSV.foreach(filepath2, headers: :first_row) do |row|
  # API search here for nutrient score
  # save nutriscore to a variable like score
  # You might need a condition to not create an Ingredient without a nutriscore, unless a nutriscore is not required
  Unit.create!(name: row['UnitEN']) # nutriscore: score
end

puts "=== UNIT SEEDED ==="


puts "=== START SEEDING USER AND RECIPES ==="
10.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email(domain: 'example'),
    password: Faker::Internet.password(min_length: 6),
    phone_number: Faker::PhoneNumber.phone_number_with_country_code
  )
end
puts "=== USER AND RECIPES SEEDED==="
