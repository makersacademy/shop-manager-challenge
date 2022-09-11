require_relative "./order"
require_relative "./item"

class OrderRepository

  # need to have a way to add items for the create method

  # Selecting all records
  def all
    sql = "SELECT orders.id, orders.customer_name, orders.date_placed, items.name AS item_name, items.unit_price AS item_price FROM orders JOIN items_orders ON orders.id = items_orders.order_id JOIN items ON items.id = items_orders.item_id;"
    result_set = DatabaseConnection.exec_params(sql, [])
    
    orders = []
    order = nil
    previous_id = 0
    result_set.each do |record|
      if record['id'] != previous_id
        orders << order if previous_id != 0
        order = Order.new
        order.id = record['id']
        order.customer_name = record['customer_name']
        order.date_placed = record['date_placed']
      end
      item = Item.new
      item.name = record['item_name']
      item.unit_price = record['item_price']
      order.items << item # ??
      
      previous_id = record['id']
    end
    orders << order

    return orders
  end

  # Creates a new record
  def create(order)
    # insert into orders table, returning the id of the new order
    sql = "INSERT INTO orders (customer_name, date_placed) VALUES ($1, $2) RETURNING id;"
    params = [order.customer_name, order.date_placed]
    result = DatabaseConnection.exec_params(sql, params)
    order_id = result[0]['id']
    order.items.each do |item|
      # getting the id for the item to add
      sql = "SELECT id FROM items WHERE name = $1;"
      result = DatabaseConnection.exec_params(sql, [item.name])
      item_id = result[0]['id']

      # insert into join table
      sql = "INSERT INTO items_orders (item_id, order_id) VALUES ($1, $2);"
      params = [item_id, order_id]
      DatabaseConnection.exec_params(sql, params)
    end

    return nil
  end

end