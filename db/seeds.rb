require "open-uri"

start = Time.now

puts "=== DESTROYING TABLES ==="

User.destroy_all
puts "User destroyed"

Ingredient.destroy_all
puts "Ingredient destroyed"

#############################################
# Ingredient
#############################################

#############################################
# Recipe
#############################################

#############################################
# User
#############################################
