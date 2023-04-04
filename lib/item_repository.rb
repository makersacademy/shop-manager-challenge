require_relative './item'

class ItemRepository
  def all
    sql = 'SELECT * FROM items'
    result_set = DatabaseConnection.exec_params(sql, [])
    
    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record['id'].to_i
      item.item_name = record['item_name']
      item.unit_price = record['unit_price'].to_f
      item.quantity = record['quantity'].to_i
      
      items << item
    end

    return items
  end

  def find(id)
    sql = 'SELECT * FROM items WHERE id = $1;'
    result = DatabaseConnection.exec_params(sql, [id])
  
    return nil if result.ntuples.zero? 
    #returns the number of rows in the result set, and zero? 
    # is a method that returns true if the number is equal to zero.
  
    record = result.first
    item = Item.new
    item.id = record['id'].to_i
    item.item_name = record['item_name']
    item.unit_price = record['unit_price'].to_f
    item.quantity = record['quantity'].to_i
  
    item
  end  

  def create(item)
    sql = 'INSERT INTO items (item_name, unit_price, quantity) VALUES ($1, $2, $3) RETURNING id;'
    result = DatabaseConnection.exec_params(sql, [item.item_name, item.unit_price, item.quantity])
    item.id = result.first['id'].to_i
  end

  def update(id, item)
    sql = 'UPDATE items SET item_name = $1, unit_price = $2, quantity = $3 WHERE id = $4'
    DatabaseConnection.exec_params(sql, [item.item_name, item.unit_price, item.quantity, id])
  end

  def delete(id)
    sql = 'DELETE FROM items WHERE id = $1'
    DatabaseConnection.exec_params(sql, [id])
  end
end