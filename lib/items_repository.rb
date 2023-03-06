require_relative './items'

require_relative './database_connection'

class ItemsRepository
  def all
    sql = 'SELECT * FROM items;'
    
    result_set = DatabaseConnection.exec_params(sql, []) 

    items =[]

    result_set.each do |records|
      item = Items.new
      item.id = records['id'].to_i
      item.name = records['name']
      item.price = records['price'].to_f
      item.quantity = records['quantity'].to_i
      items << item
    end
    return items
  end 

  def create(item)
    sql = 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);'
    params = [item.name, item.price, item.quantity]
    result_set = DatabaseConnection.exec_params(sql, params) 
  end
end 