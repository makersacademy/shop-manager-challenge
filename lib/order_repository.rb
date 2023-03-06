require_relative "./order"
require_relative "./item"
require_relative "./shared_methods"

class OrderRepository

  #-----------------
  # ALL
  #-----------------

  def all
    sql = 'SELECT * FROM orders;'
    result = DatabaseConnection.exec_params(sql, [])
    
    orders = []
    result.each { |record| orders << Record.to_order(record) } # method in ./shared_methods.rb
    orders.map! { |order| find(order.id) } # get items for order.items

    return orders # return orders with their respective items
  end

  #-----------------
  # FIND
  #-----------------

  def find(id)
    sql = _sql_for_find_method
    result = DatabaseConnection.exec_params(sql, [id])

    record = result.first

    order = Record.to_order(record) # get order
    result.each { |record| order.items << Record.to_item(record) } # get items for order.items

    return order
  end

  #-----------------
  # CREATE
  #-----------------

  def create(order)
    sql_params = [order.date, order.customer]
    _add_new_order(sql_params)
    
    order_id = _get_order_id(sql_params)
    _link_new_items_to_order_in_join_table(order_id, order)

    # update items remaining stock when they are added to a new order
    _update_stock(order) 
  end

  #-----------------
  # UPDATE
  #-----------------

  def update(order)
    sql = "UPDATE orders SET date = $1, customer = $2 WHERE id = $3;"
    sql_params = [order.date, order.customer, order.id]
    DatabaseConnection.exec_params(sql, sql_params)

    # rearrange connections between the order and the items
    _delete_from_join_table(order.id)
    _link_new_items_to_order_in_join_table(order.id, order)
  end

  #-----------------
  # DELETE
  #-----------------

  def delete(id)
    sql = "DELETE FROM orders WHERE id = $1;"
    DatabaseConnection.exec_params(sql, [id])
  end

  #-----------------
  # PRIVATE METHODS
  #----------------- 

  private

  def _sql_for_find_method
    return 'SELECT orders.id, orders.date, orders.customer, 
                  items.id AS "itemID", items.name, items.price, items.quantity
            FROM items 
            JOIN orders_items ON orders_items.item_id = items.id
            JOIN orders ON orders_items.order_id = orders.id
            WHERE orders.id = $1;'
  end

  def _add_new_order(sql_params)
    sql = "INSERT INTO orders (date, customer) VALUES($1, $2);"
    DatabaseConnection.exec_params(sql, sql_params)
  end

  def _get_order_id(sql_params)
    sql = "SELECT * FROM orders WHERE date = $1 AND customer = $2;"
    DatabaseConnection.exec_params(sql, sql_params).first["id"]
  end

  def _link_new_items_to_order_in_join_table(order_id, order)
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
