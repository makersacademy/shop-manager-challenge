require_relative '../lib/database_connection.rb'
require_relative '../lib/order.rb'

class OrderRepostiory

    def all
        query = "SELECT id, customer,item_id, date FROM orders;"
        params = []
        result_set = DatabaseConnection.exec_params(query, params)
        orders = []

        result_set.each do |record|
            order = Order.new
            order.id = record["id"]
            order.customer = record["customer"]
            order.date = record["date"]
            order.item_id = record["item_id"]

            orders << order
        end
        orders

    end

    def create(order)
        sql = 'INSERT INTO orders (customer, item_id, date) VALUES($1, $2, $3);'
        sql_params = [order.customer, order.item_id, order.date]
        DatabaseConnection.exec_params(sql,sql_params)

    end

end