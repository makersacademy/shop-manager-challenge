require_relative './order_item'
require 'bigdecimal'

class OrderItemRepository
  def all
    order_items = []

    query = <<-SQL
      SELECT orders.id AS order_id, orders.customer_name, orders.order_date,
             items.id AS item_id, items.name, items.unit_price, items.quantity
      FROM order_items
      JOIN orders ON orders.id = order_items.order_id
      JOIN items ON items.id = order_items.item_id
    SQL

    result_set = DatabaseConnection.exec_params(query, [])

    result_set.each do |row|
      order_items << result_order_item(row)
    end

    return order_items
  end

  def find(order_id)
    order_items = []

    query = <<-SQL
      SELECT items.id AS item_id, items.name, items.unit_price, items.quantity
      FROM order_items
      JOIN items ON items.id = order_items.item_id
      WHERE order_items.order_id = $1
    SQL

    params = [order_id]

    result_set = DatabaseConnection.exec_params(query, params)

    result_set.each do |row|
      order_items << result_item_order(row, order_id)
    end

    return order_items
  end

  def create(order_id, item_id)
    @order_items ||= []  # Initialize @order_items if it's nil
  
    existing_order_item = @order_items.find { |oi| oi.item_id == item_id }
  
    if existing_order_item
      update_quantity(existing_order_item)
    else
      insert_new_order_item(order_id, item_id)
      order_item = OrderItem.new
      order_item.order_id = order_id
      order_item.item_id = item_id
      order_item.quantity = 1
      @order_items << order_item
      existing_order_item = order_item  # Update existing_order_item with the newly added item
    end
  
    return nil
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
    order = Order.new
    order.id = row['order_id'].to_i
    order.customer_name = row['customer_name']
    order.order_date = row['order_date']

    item = Item.new
    item.id = row['item_id'].to_i
    item.name = row['name']
    item.unit_price = BigDecimal(row['unit_price'])
    item.quantity = row['quantity'].to_i

    order_item = OrderItem.new
    order_item.order = order
    order_item.item = item

    return order_item
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
end
