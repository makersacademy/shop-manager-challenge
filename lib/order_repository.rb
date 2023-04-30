require_relative "./order"

class OrderRepository
  def all
    sql = "SELECT * FROM orders;"
    records = DatabaseConnection.exec_params(sql, [])
    records.map { |record| convert_record_to_order(record) }
  end

  def all_with_items
    sql = "SELECT id FROM orders;"
    records = DatabaseConnection.exec_params(sql, [])
    orders = []
    records.each do |record|
      # binding.irb
      id = (record["id"]).to_i
      order = find_with_items(id)
      orders << order
    end
    orders
  end

  def find_with_items(id)
    sql = "SELECT 
            orders.id AS id,
            orders.customer_name AS customer_name,
            orders.date_placed AS date_placed,
            items.id AS items_id,
            items.name AS items_name,
            items.unit_price AS items_unit_price,
            items.quantity AS items_quantity
          FROM orders
            JOIN items_orders ON orders.id = items_orders.order_id
            JOIN items ON items.id = items_orders.item_id
          WHERE orders.id = $1;"

    records = DatabaseConnection.exec_params(sql, [id])
    order = convert_record_to_order(records.first)
    records.each do |record|
      item = Item.new
      item.id = record["items_id"]
      item.name = record["items_name"]
      item.unit_price = record["items_unit_price"]
      item.quantity = record["items_quantity"]
      order.items << item
    end
    order
  end
  
  def create(order)
    sql = "INSERT INTO orders (customer_name, date_placed)
    VALUES ($1, $2)"
    params = [order.customer_name, order.date_placed]
    DatabaseConnection.exec_params(sql, params)
  end
  
  private
  
  def convert_record_to_order(record)
    order = Order.new
    order.id = record["id"]
    order.customer_name = record["customer_name"]
    order.date_placed = record["date_placed"]
    order
  end
end
