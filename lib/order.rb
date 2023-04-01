class Order
  attr_accessor :id, :customer, :date

  def add_item(item)
    order_id = self.id
    item_id = item.id

    join_sql = 'INSERT INTO items_orders (item_id, order_id) VALUES ($1, $2);'
    join_params = [item_id, order_id]

    DatabaseConnection.exec_params(join_sql, join_params)
  end
end
