require_relative './item'

class ItemRepo
  def all
    items = []

    sql = 'SELECT * FROM items;'

    results = DatabaseConnection.exec_params(sql, [])

    results.each do |result|
      items << new_item(result)
    end
    
    return items
  end

  def find_items_by_order(number)
    items = []

    sql = 'SELECT * FROM items
              JOIN items_orders_join ON items_orders_join.item_id = items.id
              JOIN orders ON items_orders_join.order_id = orders.id
              WHERE orders.id = $1;'

    results = DatabaseConnection.exec_params(sql, [number])

    results.each do |result|
      items << new_item(result)
    end
    
    return items
  end
  
  def create_item(item)
    name = item.name
    price = item.unit_price
    quantity = item.quantity
    
    params = [name, price, quantity]
    
    sql = 'INSERT INTO items (name, unit_price, quantity)
    VALUES ($1, $2, $3);'
    
    DatabaseConnection.exec_params(sql, params)
  end
  
  private

  def new_item(result)
    item = Item.new
  
    item.id = result['id']
    item.name = result['name']
    item.unit_price = result['unit_price']
    item.quantity = result['quantity']
    
    return item
  end
end
