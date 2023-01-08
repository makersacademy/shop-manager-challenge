require_relative './item'

class ItemRepository
  def all
    items = []
    sql = "SELECT id, item_name, quantity, unit_price FROM items;"
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      item = Item.new

      item.id = record['id'].to_i
      item.item_name = record['item_name']
      item.quantity = record['quantity'].to_i
      item.unit_price = record['unit_price'].to_i
      items << item
    end
    return items
  end

  def find(id)
    sql = 'SELECT id, item_name, quantity, unit_price FROM items WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]
    item = Item.new
    item.id = record['id'].to_i
    item.item_name = record['item_name']
    item.quantity = record['quantity'].to_i
    item.unit_price = record['unit_price']
      
    return item

  end
    
  def update_item_name(item_name, id)
    items = []
    sql = 'UPDATE items
            SET item_name = $1 WHERE id = $2 RETURNING * ;'
    sql_params = [item_name, id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    result_set.each do |record|
      item = Item.new
      item.id = record['id'].to_i
      item.item_name = record['item_name']
      item.quantity = record['quantity'].to_i
      item.unit_price = record['unit_price'].to_i
      items << item
    end
    return items
  end 

  def update_unit_price(unit_price, id)
    items = []
    sql = 'UPDATE items
            SET unit_price = $1 WHERE id = $2 RETURNING * ;'
    sql_params = [unit_price, id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
      
    result_set.each do |record|
      item = Item.new

      item.id = record['id'].to_i
      item.item_name = record['item_name']
      item.quantity = record['quantity'].to_i
      item.unit_price = record['unit_price'].to_i
      items << item
    end
    return items
  end 

  def update_item_quantity(quantity, id)
    items = []
    sql = 'UPDATE items
            SET quantity = $1 WHERE id = $2 RETURNING * ;'
    sql_params = [quantity, id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
      
    result_set.each do |record|
      item = Item.new

      item.id = record['id'].to_i
      item.item_name = record['item_name']
      item.quantity = record['quantity'].to_i
      item.unit_price = record['unit_price'].to_i
      items << item
    end
    return items
  end 
  def create(item)
    items = []
    sql = 'INSERT INTO items(item_name, unit_price, quantity) VALUES($1, $2, $3) RETURNING *; '
    sql_params = [item.item_name, item.unit_price, item.quantity]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
      
    result_set.each do |record|
      item = Item.new

      item.id = record['id'].to_i
      item.item_name = record['item_name']
      item.quantity = record['quantity'].to_i
      item.unit_price = record['unit_price'].to_i
      items << item
    end
    return items
end

    

end
