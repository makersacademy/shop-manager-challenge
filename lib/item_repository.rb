require_relative 'item'

class ItemRepository
  def all
    sql = 'SELECT id, name, unit_price, stock_quantity FROM items;'
    result = DatabaseConnection.exec_params(sql, [])
    items_array = []
    result.each do |row|
      item = Item.new
      item.id, item.name, item.unit_price, item.stock_quantity = 
        row['id'], row['name'], row['unit_price'], row['stock_quantity']
      items_array << item
    end
    return items_array
  end
  
  def find(id)
    sql = 'SELECT id, name, unit_price, stock_quantity FROM items WHERE id = $1'
    param = [id]
    result = DatabaseConnection.exec_params(sql, param)
    row = result.first

    item = Item.new
    item.id, item.name, item.unit_price, item.stock_quantity = 
      row['id'], row['name'], row['unit_price'], row['stock_quantity']
    return item
  end
  
  def create(item)
    sql = 'INSERT INTO items (name, unit_price, stock_quantity) VALUES ($1, $2, $3)'
    params = [item.name, item.unit_price, item.stock_quantity]
    DatabaseConnection.exec_params(sql, params)

    return nil
  end
  
  def delete(id)
    sql = "DELETE FROM items WHERE id = $1"
    param = [id]
    DatabaseConnection.exec_params(sql, param)
    
    return nil
  end
  
  def update(item)
    sql = "UPDATE items SET name = $1, unit_price = $2, stock_quantity = $3 WHERE id = $4"
    params = [item.name, item.unit_price, item.stock_quantity, item.id]
    DatabaseConnection.exec_params(sql, params)

    return nil
  end
end
