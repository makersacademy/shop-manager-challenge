require_relative "./order"
require_relative "./item"
require_relative "./shared_methods"

class OrderRepository
  def all
    sql = 'SELECT * FROM orders;'
    result = DatabaseConnection.exec_params(sql, [])
    
    # converts hash to order objects with no items
    orders = []
    result.each { |record| orders << Record.to_order(record) }

    # adds items to order objects
    orders.map! { |order| find(order.id) }

    return orders

  end

  def find(id)
    sql = _sql_for_find_method
    result = DatabaseConnection.exec_params(sql, [id])

    # converts hash to order object
    record = result.first
    order = Record.to_order(record)

    # add items into the order.items array
    result.each { |record| order.items << Record.to_item(record) }

    return order

  end

  def create(order)
    sql_params = [order.date, order.customer]
    _add_new_order_to_orders(sql_params)
    
    order_id = _get_order_id(sql_params)
    _link_items_id_to_new_order(order_id, order)
    
    _update_stock(order)
  end

  def update(order)
    sql = "UPDATE orders SET date = $1, customer = $2 WHERE id = $3;"
    sql_params = [order.date, order.customer, order.id]
    DatabaseConnection.exec_params(sql, sql_params)

    _delete_from_join_table(order.id)
    _link_items_id_to_new_order(order.id, order)
  end

  def delete(id)
    sql = "DELETE FROM orders WHERE id = $1;"
    DatabaseConnection.exec_params(sql, [id])
  end

  private

  def _sql_for_find_method
    return 'SELECT orders.id, orders.date, orders.customer, 
                  items.id AS "itemID", items.name, items.price, items.quantity
            FROM items 
            JOIN orders_items ON orders_items.item_id = items.id
            JOIN orders ON orders_items.order_id = orders.id
            WHERE orders.id = $1;'
  end

  def _add_new_order_to_orders(sql_params)
    sql = "INSERT INTO orders (date, customer) VALUES($1, $2);"
    DatabaseConnection.exec_params(sql, sql_params)
  end

  def _get_order_id(sql_params)
    sql = "SELECT * FROM orders WHERE date = $1 AND customer = $2;"
    DatabaseConnection.exec_params(sql, sql_params).first["id"]
  end

  def _link_items_id_to_new_order(order_id, order)
    order.items.each do |item|
      sql = "INSERT INTO orders_items (order_id, item_id) VALUES($1, $2);"
      sql_params = [order_id, item.id]
      DatabaseConnection.exec_params(sql, sql_params)
    end
  end

  def _update_stock(order)
    order.items.each do |item|
      remaining_stock = item.quantity - 1
      sql = "UPDATE items SET quantity = $1 WHERE id = $2;"
      sql_params = [remaining_stock, item.id]
      DatabaseConnection.exec_params(sql, sql_params)
    end
  end

  def _delete_from_join_table(id)
    sql = "DELETE FROM orders_items WHERE order_id = $1;"
    DatabaseConnection.exec_params(sql, [id])
  end
end
