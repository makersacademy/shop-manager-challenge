class OrderRepository
  # def initialize(database_connection:)
  #   @database_connection = database_connection
  # end
  def create(order)
    sql = 'INSERT INTO orders (customer, date, item_id) VALUES ($1, $2, $3);'
    params = [order.customer, order.date, order.item_id]
    DatabaseConnection.exec_params(sql, params)
  end

  def all_with_item
    sql = 'SELECT orders.customer,
                  orders.date,
                  orders.id AS order_id,
                  items.name,
                  items.price,
                  items.stock,
                  items.id AS item_id
            FROM orders 
            JOIN items ON orders.item_id = items.id'
    result = DatabaseConnection.exec_params(sql, [])
    orders = []
    result.each do |record|
      item = Item.new(
        name: record["name"],
        price: record['price'],
        stock: record['stock'],
      )
      item.id = record['item_id']
      order = Order.new(
        customer: record['customer'],
        date: record['date']
      )
      order.item = item
      order.item_id = item.id
      order.id = record['order_id']
      orders << order
    end
    orders
  end
end
