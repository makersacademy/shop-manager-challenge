# Test drive this

# Table name: recipes

# Repository class
# (in lib/shop_manager_challenge_repository.rb)

require_relative './shop_manager_challenge'

class ShopManagerRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = 'SELECT id, name, cooking_time, rating FROM recipes;'
    sql_params = []
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    recipes = [] 
    result_set.each do |record|

      recipe = Recipe.new
      recipe.id = record['id']
      recipe.name = record['name']
      recipe.cooking_time = record['cooking_time']
      recipe.rating = record['rating']
      
      recipes << recipe
    end

    return recipes
    
    
    #return recipe
  end  

    # Returns an array of Recipe objects

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    sql = 'SELECT id, name, cooking_time, rating FROM recipes WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]

    
    recipe = Recipe.new
    recipe.id = record['id']
    recipe.name = record['name']
    recipe.cooking_time = record['cooking_time']
    recipe.rating = record['rating']

    return recipe
  end  
end