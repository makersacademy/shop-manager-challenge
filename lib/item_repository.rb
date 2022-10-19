require_relative './item'

class ItemRepository
  
  def all
    sql_query = 'SELECT * FROM items;'
    sql_params = []
    result_set = DatabaseConnection.exec_params(sql_query, sql_params)
    
    all_items = result_set.map do |record|
      record_to_item(record)
    end
    
    return all_items
  end
  
  def find(id)
    sql_query = 'SELECT * FROM items WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql_query, sql_params)
    result_set = result_set.map do |record|
      record_to_item(record)
    end
    
    if result_set.empty?
      return false
    else
      find_result = result_set.first
      return find_result
    end
  end
  
  def create(item)
    sql_query = 'INSERT INTO items (item, unit_price, quantity) VALUES ($1, $2, $3);'
    sql_params = [item.item, item.unit_price, item.quantity]
    DatabaseConnection.exec_params(sql_query, sql_params)
    return nil
  end
  
  def find_by_order(order_id)
    sql_query = "SELECT items.id, items.item, items.unit_price, items.quantity FROM items \
      JOIN items_orders ON items_orders.item_id = items.id \
      JOIN orders ON items_orders.order_id = orders.id \
      WHERE orders.id = $1"
    sql_params = [order_id]
    result_set = DatabaseConnection.exec_params(sql_query, sql_params)
    
    items = result_set.map do |record|
      record_to_item(record)
    end
    
    p items
    
    return items
  end
  
  private
  
  def record_to_item(record)
    item = Item.new
    item.id = record['id'].to_i
    item.item = record['item']
    item.unit_price = record['unit_price'].to_f
    item.quantity = record['quantity'].to_i
    return item
  end
  
end
