class OrderRepository

  def all
    sql = 'SELECT id, name, cooking_time_mins, rating FROM recipes;'
    result_set = DatabaseConnection.exec_params(sql, [])

    recipes = []

    result_set.each do |record|
      recipe = Recipe.new
      recipe.id = record['id']
      recipe.name = record['name']
      recipe.cooking_time_mins = record['cooking_time_mins']
      recipe.rating = record['rating']

      recipes << recipe
    end
  end


  def create

  end

end