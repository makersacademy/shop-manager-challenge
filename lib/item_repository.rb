require 'item'
require_relative 'item'
require_relative 'database_connection'
class ItemRepository

    # Selecting all records
    # No arguments
    def all
      # Executes the SQL query:
      result_set = DatabaseConnection.exec_params('SELECT id, item_name, unit_price, quantity, order_id FROM items;',[])
      items = []
      result_set.each do |a_item|
        item = Item.new
        item.id = a_item['id']
        item.item_name = a_item['item_name']
        item.unit_price = a_item['unit_price']
        item.quantity = a_item['quantity']
        item.order_id = a_item['order_id']
        items << item
      end
      return items
      # Returns an array of Item objects.
    end
  
    # Gets a single record by its ID
    # One argument: the id (number)
    def find(id)
      # Executes the SQL query:
     
  
      # Returns a single Item object.
    end
  
    # Add more methods below for each operation you'd like to implement.
  
    # def create(item)
    # end
  
    # def update(item)
    # end
  
    # def delete(item)
    # end
  end