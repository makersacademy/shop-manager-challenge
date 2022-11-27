class OrderRepository

    def all
  
      sql = 'SELECT orders.id,
            orders.customer_name,
            orders.date,
            items.id AS item_id,
            items.name
            FROM orders
            JOIN items
            ON items.id = orders.item_id;'
          # Returns an array of item hashes.
          result_set = DatabaseConnection.exec_params(sql, [])

          result_set.map { |result| result }
    end
  
    def create(order)
      # INSERT INTO items (customer_name, date) VALUES ($1, $2)
    end
  
  end