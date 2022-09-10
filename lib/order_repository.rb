require_relative './order'
require_relative './database_connection'

class OrderRepository

  def all_orders

    sql = "SELECT * FROM orders;"
    sql_params = []
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    
    orders = []    
    result_set.each do |record|
      order = Order.new

      order.id = record['id']
      order.customer = record['customer']
      order.item = record['item']
      order.date = record ['date']

      orders << order
    end

    return orders
  end

  def create_order(order) 
    
    # the following is a temporary fix
    # to ensure order id's and item id's are linked
    # on the join table 'items_orders.sql'
    # a long-term fix to enable much more efficient code / SQL queries
    # is to add item id to 'orders' table, not just item name (text)
    
    # order insertion
    sql = "INSERT INTO orders (customer, item, date) VALUES ($1, $2, $3);"
    sql_params = [order.customer, order.item, order.date]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    # return all orders to target the last order (this order)
    sql_2 = "SELECT * FROM orders;"
    sql_params_2 = []
    result_set_2 = DatabaseConnection.exec_params(sql_2, sql_params_2)

    orders = []
    result_set_2.each do |order|
      orders << order
    end
  
    order_id_no = orders.last["id"]    

    # filter through 'items' table to match item name with item id
    sql_3 = "SELECT items.id AS item_id, items.name AS item_name  
              FROM items WHERE name = $1;"
    sql_params_3 = [order.item]
    result_set_3 = DatabaseConnection.exec_params(sql_3, sql_params_3)
    
    order_item_id = result_set_3[0]["item_id"]

    # finally add item id and order into join table called 'items_orders'
    sql_4 = "INSERT INTO items_orders (item_id, order_id) VALUES ($1, $2);"
    sql_params_4 = [order_item_id, order_id_no]
    result_set_4 = DatabaseConnection.exec_params(sql_4, sql_params_4)    
    
  end 

end

# # original 'create_order' method that does not link order id's with items id's
# def create_order(order)
#   sql = "INSERT INTO orders (customer, item, date) VALUES ($1, $2, $3);"
#   sql_params = [order.customer, order.item, order.date]
#   result_set = DatabaseConnection.exec_params(sql, sql_params)
# end