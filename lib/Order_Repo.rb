require 'Order'


class Orders_Repo

    def all
        list = []
        sql = 'SELECT id, customer_name, date, item_id FROM orders;'
        result_set = DatabaseConnection.exec_params(sql, [])
        result_set.each do |record|
          orders = Orders.new
          orders.id = record['id']
          orders.customer_name = record['customer_name']
          orders.date = record['date']
          orders.item_id = record['item_id']
          list << orders
        end
      return list
    end

    def create(order)
        sql = 'INSERT INTO orders(customer_name, date, item_id) VALUES ($1, $2, $3);'
        sql_params = [order.customer_name, order.date, order.item_id]
        result_set = DatabaseConnection.exec_params(sql, sql_params)
        return nil
    end
end