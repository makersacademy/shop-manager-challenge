class ItemRepository

    # Selecting all records
    # No arguments
    def all
      items = []
      # Executes the SQL query:
      # SELECT orders.id AS ord_id, customer_name, date, items.id AS it_id, name, price, quantity
      # FROM orders
      # JOIN items_orders ON items_orders.order_id = orders.id
      # JOIN items ON items_orders.item_id = items.id;
      sql = 'SELECT * FROM items'
      results = DatabaseConnection.exec_params(sql, [])
      results.each do |result|
        item = Item.new
        item.id = result['id']
        item.name = result['name']
        item.price = result['price']
        item.quantity = result['quantity']
        items << item
      end

      sql = 'SELECT * FROM items_orders'
      results = DatabaseConnection.exec_params(sql, [])
      results.each do |order|
        item = items[items.index{|element| element.id == order['item_id']}]
        item.orders << order['order_id']
      end
  
      # Returns an array of Item objects.
      return items
    end
  
    def create(item)
      # Executes the SQL query:
      # INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3)
      # INSERT INTO items_orders (item_id, order_id) VALUES ($4, $5)
      sql = "INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);"
      params = [item.name, item.price, item.quantity]
      DatabaseConnection.exec_params(sql, params)
    end
end