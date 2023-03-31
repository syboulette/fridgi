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

filepath = "db/ingredients.csv"

CSV.foreach(filepath, headers: :first_row) do |row|
  # API search here for nutrient score
  # save nutriscore to a variable like score
  # You might need a condition to not create an Ingredient without a nutriscore, unless a nutriscore is not required
  Ingredient.create!(name: row['IngredientNameEN']) # nutriscore: score
end
#############################################
# Recipe
#############################################

#############################################
# User
#############################################
puts 'creating users...'

filepath = "db/units.csv"
CSV.foreach(filepath2, headers: :first_row) do |row|
  Unit.create!(name: row['UnitEN'])
end

20.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email(domain: 'example'),
    password: Faker::Internet.password(min_length: 6),
    phone_number: Faker::PhoneNumber.phone_number_with_country_code
  )
  2.times do
    recipe = user.recipes.create(
      title: Faker::Food.dish,
      prep_time: Faker::Number.between(from: 5, to: 60),
      instruction: Faker::Food.description,
      difficulty: Faker::Number.between(from: 1, to: 5),
      utensil: Faker::Food.measurement,
      cooking_time: Faker::Number.between(from: 5, to: 120),
      total_time: 5,
      serving: Faker::Number.between(from: 1, to: 12)
    )
    total_time = recipe.cooking_time + recipe.cooking_time

    # Fetch a random food image from Unsplash
    query = recipe.title
    image = Unsplash::Photo.random(query: query, orientation: 'landscape')
    recipe.image.attach(io: URI.open(image.urls.regular), filename: 'recipe_image.jpg')

    recipe.update(total_time: total_time)
  end
end

puts 'Finished seeding users!'
