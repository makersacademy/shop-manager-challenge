require_relative './order'
require 'date'

class OrderRepository
    def all
        result = DatabaseConnection.exec_params('SELECT id, customer_name, date FROM orders;', [])

        all_orders = []

        result.each do |record|
            new_order = Order.new
            new_order.id = record['id'].to_i
            new_order.customer_name = record['customer_name']
            new_order.date = record['date']

            all_orders << new_order
        end
        return all_orders

    end

    def create
        puts "Enter your name"
        customer_name = gets.chomp
            if customer_name == "STOP"
                return nil
            end
        date = DateTime.now
        date.strftime("%Y/%m/%d")

        sql = 'INSERT INTO orders (customer_name, date) VALUES ($1, $2);'
        sql_params = [customer_name, date]
        
        DatabaseConnection.exec_params(sql, sql_params)
        puts "Order created"
    end
end