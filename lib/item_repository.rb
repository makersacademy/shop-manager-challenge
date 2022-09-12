require_relative './item'
require_relative './database_connection'

class ItemRepository

  def all_items    

    sql = "SELECT * FROM items;"
    sql_params = []
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    
    items = []    
    result_set.each do |record|
      item = Item.new

      item.id = record['id']
      item.name = record['name']
      item.price = record['price']
      item.stock_qty = record ['stock_qty']

      items << item
    end

    return items
  end

  def create_item(item)
    sql = "INSERT INTO items (name, price, stock_qty) VALUES ($1, $2, $3);"
    sql_params = [item.name, item.price, item.stock_qty]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
  end

  

end