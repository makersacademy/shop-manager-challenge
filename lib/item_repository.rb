require_relative "./item"
require_relative "./order"
require_relative "./shared_methods"

class ItemRepository
  def all
    sql = 'SELECT id AS "itemID", * FROM items;'
    result = DatabaseConnection.exec_params(sql, [])

    items = []
    result.each do |record|
      items << Record.to_item(record)
    end

    return items

  end

  def find(id)
    sql = 'SELECT id AS "itemID", * FROM items WHERE id = $1;'
    result = DatabaseConnection.exec_params(sql, [id])

    return Record.to_item(result[0])
  end

  def find_with_orders(id)
    sql = _sql_for_find_method
    result = DatabaseConnection.exec_params(sql, [id])

    orders = []
    result.each do |record|
      orders << Record.to_order(record)
    end

    return orders
  end

  def create(item)
    sql = "INSERT INTO items (name, price, quantity) VALUES($1, $2, $3);"
    sql_params = [item.name, item.price, item.quantity]
    DatabaseConnection.exec_params(sql, sql_params)
  end

  def update(item)
    sql = "UPDATE items SET name = $1, price = $2, quantity = $3 WHERE id = $4;"
    sql_params = [item.name, item.price, item.quantity, item.id]
    DatabaseConnection.exec_params(sql, sql_params)
  end

  def delete(id)
    sql = 'DELETE FROM items WHERE id = $1;'
    DatabaseConnection.exec_params(sql, [id])
  end

  private

  def _sql_for_find_method
    return 'SELECT orders.id, orders.date, orders.customer 
              FROM orders 
              JOIN orders_items ON orders_items.order_id = orders.id
              JOIN items ON orders_items.item_id = items.id
              WHERE items.id = $1;'
  end
end
