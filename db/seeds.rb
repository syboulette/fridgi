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
user = User.create!({
  first_name: "Louis", 
  last_name: "Ramos",
  email: "louisramosdev@gmail.com",
  password: "password"
  # birthdate: Date.new(1995, 7, 1)
})

# photo = URI.open("https://scontent.fcrl2-1.fna.fbcdn.net/v/t39.30808-6/282622606_10227257972500962_5341841762778350698_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=ViiS6LhHjtoAX_gyQly&tn=ZnB6JIveJJ2JqrC4&_nc_ht=scontent.fcrl2-1.fna&oh=00_AfD_itwMuR4Ux2BCY_80qWYxg6dzPM49T95vlHm-IHIKWA&oe=64011675")
# user.photo.attach(io: photo, filename: "#{user.first_name}#{user.last_name}profilepicture.png", content_type: "image/png")

puts "#{user.first_name} #{user.last_name} added to the users"