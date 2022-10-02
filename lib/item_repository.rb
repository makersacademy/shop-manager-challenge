require "item"

class ItemRepository
  
  def all_items
    items = []
    sql = "SELECT id, name, unit_price, quantity FROM items;"
    result_set = DatabaseConnection.exec_params(sql, [])
    
    result_set.each do |each_item|
      item = Item.new
      item.id = each_item["id"]
      item.name = each_item["name"]
      item.unit_price = each_item["unit_price"]
      item.quantity = each_item["quantity"]

     items << item
    end
    return items
  end

  def create_item(new_item)
    sql = "INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);"
    sql_params = [new_item.name, new_item.unit_price, new_item.quantity]
    
    DatabaseConnection.exec_params(sql, sql_params)
  end

  def all_orders
    orders = []
    sql = "SELECT id, customer_name, date, item_id FROM orders;"
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |each_order|
      order = Order.new
      order.id = each_order["id"]
      order.customer_name = each_order["customer_name"]
      order.date = each_order["date"]
      order.item_id = each_order["item_id"]

      orders << order
    end
    return orders
  end

  def create_order(new_order)
    sql = "INSERT INTO orders (customer_name, date, item_id) VALUES ($1, $2, $3);"
    sql_params = [new_order.customer_name, new_order.date, new_order.item_id]
    
    DatabaseConnection.exec_params(sql, sql_params)
  end
end