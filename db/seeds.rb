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
  Ingredient.create!(name: row['name']) # nutriscore: score
end

#############################################
# Recipe
#############################################

#############################################
# User
#############################################
puts 'creating users...'

20.times do
  user = User.create!(
    first_name: Faker::Name.first_name,      #=> "Kaci"
    last_name: Faker::Name.last_name,        #=> "Ernser"
    email: Faker::Internet.email(domain: 'example'), #=> "alice@example.name"
    password: Faker::Internet.password(min_length: 6)
  )
end
puts 'Finished seeding users!'
