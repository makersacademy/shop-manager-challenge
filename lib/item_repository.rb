require 'item'

class ItemRepository

    # Selecting all records
    # No arguments
    def all

      sql = 'SELECT id, item_name, unit_price, quantity FROM shop_items;'
      result_set = DatabaseConnection.exec_params(sql,[])
      items = []

      result_set.each do |result|
        item = Item.new
        item.id = result['id']
        item.item_name = result['item_name']
        item.unit_price = result['unit_price']
        item.quantity = result['quantity']

        items << item

      end
      return items
      # Returns an array of Item objects.
    end
  
    # # Gets a single record by its ID
    # # One argument: the id (number)
    # def find(id)
    #   # Executes the SQL query:
    #   # SELECT id, item_name, unit_price, quantity FROM shop_items WHERE id = $1;
  
    #   # Returns a single Student object.
    # end
  
    def create(item)
      sql = 'INSERT INTO shop_items (item_name, unit_price, quantity) VALUES ($1,$2, $3);'
      sql_params = [item.item_name, item.unit_price,item.quantity]
      DatabaseConnection.exec_params(sql,sql_params)

      return nil
    end
  
  end