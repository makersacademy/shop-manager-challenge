require_relative "./order"

class OrderRepository
  def all
    sql = "SELECT * FROM orders;"
    records = DatabaseConnection.exec_params(sql, [])
    records.map { |record| record_to_order(record) }
  end

  def all_with_items
    sql = "SELECT id FROM orders;"
    records = DatabaseConnection.exec_params(sql, [])
    orders = []
    records.each do |record|
      id = (record["id"]).to_i
      order = find_with_items(id)
      orders << order
    end
    orders
  end

  def find(id)
    sql = "SELECT * FROM orders WHERE id = $1;"
    records = DatabaseConnection.exec_params(sql, [id])
    record_to_order(records.first)
  end

  def find_with_items(id)
    sql = "SELECT orders.id AS id, customer_name, date_placed,
            items.id AS items_id, name, unit_price, quantity
          FROM orders JOIN items_orders ON orders.id = items_orders.order_id
            JOIN items ON items.id = items_orders.item_id
          WHERE orders.id = $1;"

    records = DatabaseConnection.exec_params(sql, [id])
    return find(id) if records.ntuples.zero?
    order = record_to_order(records.first)
    records.each { |record| order.items << record_to_item(record) }
    order
  end
  
  def create(order)
    sql = "INSERT INTO orders (customer_name, date_placed)
    VALUES ($1, $2)"
    params = [order.customer_name, order.date_placed]
    DatabaseConnection.exec_params(sql, params)
  end
  
  private
  
  def record_to_order(record)
    order = Order.new
    order.id = record["id"]
    order.customer_name = record["customer_name"]
    order.date_placed = record["date_placed"]
    order
  end
  
  def record_to_item(record)
    item = Item.new
    item.id = record["items_id"]
    item.name = record["name"]
    item.unit_price = record["unit_price"]
    item.quantity = record["quantity"]
    item
  end
end
