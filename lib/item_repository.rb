require_relative './item'

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    #id, item, price, quantity
      sql = 'SELECT * FROM items;' 
      result_set = DatabaseConnection.exec_params(sql, [])
      items = []
      result_set.each do |record|
          item = Item.new
          item.id = record['id']
          item.item = record['item']
          item.price = record['price']
          item.quantity = record['quantity']
          items << item
      end
      return items
  end
  

  # Gets a single record by its ID
  # One argument: the id (number)
  # def find(id)
  #   # Executes the SQL query:
  #   sql = 'SELECT id, item, price, quantity FROM items WHERE id = $1;'
  #   params = [id]
  #   result_set = DatabaseConnection.exec_params(sql, params)
  #   items = []

  #   result_set.each do |record|
  #     item = Item.new
  #     item.id = record['id'].to_i
  #     item.item = record['item']
  #     item.price = record['price']
  #     item.quantity = record['quantity']
  #     items << item
  #   end
  #   return items
  #   # Returns a single Item object.
  # end

  # Add more methods below for each operation you'd like to implement.

  def create(item)
   # Executes the SQL query:
    # INSERT INTO items  (id, item, price, quantity) VALUES ($1, $2, $3);
    sql = 'INSERT INTO items (item, price, quantity) VALUES ($1, $2, $3);'
    params = [item.item, item.price, item.quantity]
    DatabaseConnection.exec_params(sql, params)
    
  end

  # def update(student)
  # end

  # def delete(student)
  # end
end