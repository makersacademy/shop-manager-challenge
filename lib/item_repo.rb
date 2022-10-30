require_relative 'item'

class ItemRepository
  def all
      sql = 'SELECT id, item_name, quantity, price, order_id FROM items;'
      result_set = DatabaseConnection.exec_params(sql, [])
      items = []
    
      result_set.each do |record|
        item = Item.new
        item.id = record['id']
        item.item_name = record['item_name']
        item.quantity = record['quantity']
        item.price = record['price']
        item.order_id = record['order_id']

        items << item

     end 
    return items
  end


#   # Gets a single record by its ID
#   # One argument: the id (number)
# def find(id)
#     sql = 'SELECT id, item_name, quantity, price, order_id FROM items WHERE order_id = $1;'
#     params = [id]
#     result_set = DatabaseConnection.exec_params(sql, params)

#      record = result_set[0]
    
#     item = Item.new
#     item.id = record['id']
#     item.item_name = record['item_name']
#     item.quantity = record['quantity']
#     item.price = record['price']
#     item.order_id = record['order_id']

#     return item
#   end  
  
#   def create(item)
#       # excutes SQL query;
#     sql =  'INSERT INTO items (item_name, quantity, price, order_id) VALUES($1, $2, $3, $4);'
#     sql_params = [item.item_name, item.quantity, item.price, item.order_id]

#     DatabaseConnection.exec_params(sql, sql_params)

#     return nil
#   end 
end