require_relative 'lib/recipes_directory_repository'
require_relative 'lib/database_connection'

DatabaseConnection.connect('recipes_directory_test')

RecipeRepository.new.all.each do |tired|
  p tired 
end