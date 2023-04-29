require_relative 'order'

class OrderRepository

  # Selecting all records
  def all
    orders = []
    sql = 'SELECT * FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      order = Order.new
      set_attributes(order, record)
      orders << order
    end

    orders
  end

  # creates a new order
  # returns nothing
  def create(order)
    sql = 'INSERT INTO orders (customer_name, order_date) VALUES ($1, $2);'
    params = [order.customer_name, order.order_date]
    DatabaseConnection.exec_params(sql, params)

    return nil
  end

  # adds an item to an order. 
  # fails if item is already on order?
  def assign_item_to_order(item_id, order_id)
    # Executes the SQL query:
    # INSERT INTO items_orders VALUES ($1, $2)
    # returns nothing.
  end


  private

  def set_attributes(order, record)
    order.id = record['id'].to_i
    order.customer_name = record['customer_name']
    order.order_date = record['order_date']
  end
end