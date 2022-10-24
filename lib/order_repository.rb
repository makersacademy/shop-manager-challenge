class OrderRepository

    # Selecting all records
    # No arguments
    def all
      orders = []
      # Executes the SQL query:
      # SELECT orders.id AS ord_id, customer_name, date, items.id AS it_id, name, price, quantity
      # FROM orders
      # JOIN items_orders ON items_orders.order_id = orders.id
      # JOIN items ON items_orders.item_id = items.id;
      results = DatabaseConnection.exec_params('SELECT * FROM orders', [])
      results.each do |result| 
        order = Order.new
        order.id = result['id']
        order.customer_name = result['customer_name']
        order.date = result['date']
        order.items = []
        orders << order
      end
      results = DatabaseConnection.exec_params('SELECT * FROM items_orders', [])
      results.each do |result|
        order = orders[orders.index{|element| element.id == result['order_id']}]
        order.items << result['item_id']
      end

      # Returns an array of Order objects.
      return orders
    end
  
    def create(order)
      # Executes the SQL query:
      # INSERT INTO orders (customer_name, date) VALUES ($1, $2)
      sql = 'INSERT INTO orders (customer_name, date) VALUES ($1, $2) returning *;'
      params = [order.customer_name, order.date]
      res = DatabaseConnection.exec_params(sql, params)
      order.id = res[0]['id']
      # INSERT INTO items_orders (item_id, order_id) VALUES ($3, $4)
      items = order.items
      sql = 'INSERT INTO items_orders (item_id, order_id) VALUES ($1, $2)'
      items.each do |item|
        params = [item, order.id]
        DatabaseConnection.exec_params(sql, params)
      end
    end
end