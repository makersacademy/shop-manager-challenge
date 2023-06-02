require_relative './order_item'
require 'bigdecimal'

class OrderItemRepository
  def all
    query = <<-SQL
      SELECT orders.id AS order_id, orders.customer_name, orders.order_date,
             items.id AS item_id, items.name, items.unit_price, items.quantity
      FROM order_items
      JOIN orders ON orders.id = order_items.order_id
      JOIN items ON items.id = order_items.item_id
    SQL
  
    result_set = DatabaseConnection.exec_params(query, [])
    result_set.map { |row| result_order_item(row) }
  end  

  def find(order_id)
    query = <<-SQL
      SELECT items.id AS item_id, items.name, items.unit_price, items.quantity
      FROM order_items
      JOIN items ON items.id = order_items.item_id
      WHERE order_items.order_id = $1
    SQL
  
    params = [order_id]
  
    result_set = DatabaseConnection.exec_params(query, params)
  
    result_set.map { |row| result_item_order(row, order_id) }
  end

  def create(order_id, item_id)
    @order_items ||= []  # Initialize @order_items if it's nil
  
    existing_order_item = @order_items.find { |oi| oi.item_id == item_id }
  
    if existing_order_item
      update_quantity(existing_order_item)
    else
      insert_new_order_item(order_id, item_id)
      @order_items << create_helper(order_id, item_id)
      existing_order_item = create_helper(order_id, item_id)
    end

    nil
  end
  
  def update_quantity(order_item)
    order_item.quantity += 1
  
    sql = 'UPDATE order_items SET quantity = $1 WHERE order_id = $2 AND item_id = $3;'
    params = [order_item.quantity, order_item.order_id, order_item.item_id]
  
    DatabaseConnection.exec_params(sql, params)
  
    return nil
  end

  def insert_new_order_item(order_id, item_id)
    order_item = OrderItem.new
    order_item.order_id = order_id
    order_item.item_id = item_id
    order_item.quantity = 1

    sql = 'INSERT INTO order_items (order_id, item_id, quantity) VALUES ($1, $2, $3);'
    params = [order_item.order_id, order_item.item_id, order_item.quantity]

    DatabaseConnection.exec_params(sql, params)

    return nil
  end

  private

  def result_order_item(row)
    order_item = OrderItem.new
    order_item.order = build_order(row)
    order_item.item = build_item(row)

    return order_item
  end

  def build_order(row)
    order = Order.new
    order.id = row['order_id'].to_i
    order.customer_name = row['customer_name']
    order.order_date = row['order_date']
    order
  end
  
  def build_item(row)
    item = Item.new
    item.id = row['item_id'].to_i
    item.name = row['name']
    item.unit_price = BigDecimal(row['unit_price'])
    item.quantity = row['quantity'].to_i
    item
  end

  def result_item_order(row, order_id)
    item = Item.new
    item.id = row['item_id']
    item.name = row['name']
    item.unit_price = BigDecimal(row['unit_price'])
    item.quantity = row['quantity'].to_i
  
    order_item = OrderItem.new
    order_item.order_id = order_id
    order_item.item = item
  
    return order_item
  end

  def create_helper(order_id, item_id)
    order_item = OrderItem.new
    order_item.order_id = order_id
    order_item.item_id = item_id
    order_item.quantity = 1

    return order_item
  end
end
