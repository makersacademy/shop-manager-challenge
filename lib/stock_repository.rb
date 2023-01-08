require_relative'./stock'

class StockRepository

    # Selecting all records
    # No arguments
    def all
      # Executes the SQL query:
      # SELECT id, item_name, unit_price, quantity FROM stocks;
      sql = 'SELECT id, item_name, unit_price, quantity FROM stocks;'
      result_set = DatabaseConnection.exec_params(sql,[])

      stocks = []

      result_set.each do |record|
        stock = Stock.new
        stock.id = record['id']
        stock.item_name = record['item_name']
        stock.unit_price = record['unit_price']
        stock.quantity = record['quantity']

        stocks << stock
      end
      return stocks
      # Returns an array of Order objects.
    end
  
    # Gets a single record by its ID
    # One argument: the id (number)
    def find(id)
      # Executes the SQL query:
      # SELECT id, item_name, unit_price, quantity FROM stocks WHERE id = $1;
      sql = 'SELECT id, item_name, unit_price, quantity FROM stocks WHERE id = $1;'
      sql_params = [id]

      result_set = DatabaseConnection.exec_params(sql, sql_params)

      record = result_set[0]

      stock = Stock.new
      stock.id = record['id']
      stock.item_name = record['item_name']
      stock.unit_price = record['unit_price']
      stock.quantity = record['quantity']

      return stock
      # Returns a single Stock object.
    end
  
    # Add more methods below for each operation you'd like to implement.
  
    def create(stock)
      # Executes the SQL query:
      # INSERT INTO stocks (item_name, unit_price, quantity) VALUES ($1, $2, $3);
      sql = 'INSERT INTO stocks (item_name, unit_price, quantity) VALUES ($1, $2, $3);'
      sql_params = [stock.item_name, stock.unit_price, stock.quantity]

      DatabaseConnection.exec_params(sql,sql_params)
      return nil
      # returns nothing
    end
  
    def update(stock)
      # Executes the SQL query:
      # UPDATE stocks SET item_name = $1, unit_price = $2, quantity = $3 WHERE id = $4;
      sql = 'UPDATE stocks SET item_name = $1, unit_price = $2, quantity = $3 WHERE id = $4;'
      sql_params = [stock.item_name, stock.unit_price, stock.quantity, stock.id]

      DatabaseConnection.exec_params(sql,sql_params)

      return nil
      # returns nothing
    end
  
    def delete(id)
      # Executes the SQL query:
      # DELETE FROM stocks WHERE id = $1;
      sql = 'DELETE FROM stocks WHERE id = $1;'
      sql_params = [id]

      DatabaseConnection.exec_params(sql, sql_params)

      return nil
      # returns nothing

  
    end
end