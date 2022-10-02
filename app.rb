# file: app.rb

require_relative "lib/database_connection.rb"
require_relative "lib/order_repository.rb"
require_relative "lib/item_repository.rb"

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('recipes_directory')

recipe_repository = RecipeRepository.new

recipe_repository.all.each{ |record| 
  puts "Recipe No. #{record.id} - #{record.name} - Time to Cook in mins: #{record.cooking_time_mins} - Rating: #{record.rating}" 
}