require_relative './database_connection'

class ItemRepository

    def all
      # Executes the SQL query:
      sql = 'SELECT name, price, quantity FROM items;'
      result_set = DatabaseConnection.exec_params(sql, [])
      # Returns an array of item HASHES insted of OBJECTS.
      result_set.map { |record| record } 
    end
  
    def create(item)
      sql = 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3)'
      sql_params = [item.name, item.price, item.quantity]
      result = DatabaseConnection.exec_params(sql, sql_params)
    end
  
end