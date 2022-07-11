require_relative './order'
require_relative './database_connection'


class OrderRepository

  def create(order,items_hash)
    # items_hash is a hash of items and number {item_1: 1, item_2: 2}
    query_order_id = DatabaseConnection.exec_params("INSERT INTO orders (customer_name, order_date) VALUES ($1, $2) RETURNING id", [order.customer_name,order.order_date])[0]['id']
    items_hash.each do |k,v|
      item_id = DatabaseConnection.exec_params("SELECT id FROM items WHERE name = $1",[k.name])[0]['id']
      DatabaseConnection.exec_params("INSERT INTO items_orders (orders_id, items_id, items_order_quantity) VALUES ($1,$2,$3)",[query_order_id,item_id,v])
    end 

  end 

  def show_date(order)
    query =Databas

  end

end 
