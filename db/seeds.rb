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

Unsplash.configure do |config|
  config.application_access_key = 'm4QufnEnY8uVSt7OOABFNNPI-bJzMkuFULZTgIdd6kY'
  config.application_secret = '2iOdSd572TZ3rVT10Ftl_lw1Cx_xc9AxAXEcugwfDTY'
  config.utm_source = 'fridgi'
end

20.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email(domain: 'example'),
    password: Faker::Internet.password(min_length: 6),
    phone_number: Faker::PhoneNumber.phone_number_with_country_code
  )

  num_recipes = rand(1..5)

  num_recipes.times do
    recipe = user.recipes.create(
      title: Faker::Food.dish,
      prep_time: Faker::Number.between(from: 5, to: 60),
      instruction: Faker::Food.description,
      difficulty: Faker::Number.between(from: 1, to: 5),
      utensil: Faker::Food.measurement,
      cooking_time: Faker::Number.between(from: 5, to: 120),
      total_time: 5,
      serving: Faker::Number.between(from: 1, to: 12),
    )
    total_time = recipe.cooking_time + recipe.prep_time

    # Fetch a random food image from Unsplash
    query = ["food", "meal", "dish", "repas"].sample
    image = Unsplash::Photo.random(query: query, orientation: 'landscape')
    recipe.image.attach(io: URI.open(image.urls.regular), filename: 'recipe_image.jpg')

    recipe.update(total_time: total_time)

    3.times do
      rating = Faker::Number.between(from: 2, to: 5)
      review = recipe.reviews.build(rating: rating, comment: Faker::Restaurant.review)
      review.user = user
      review.save!
    end
  end
end

puts 'Finished seeding users!'
