require_relative './order.rb'
require_relative './database_connection.rb'
require_relative './item_repository.rb'

class OrderRepository
    def all
        sql = 'SELECT * FROM orders;'
        result = DatabaseConnection.exec_params(sql, [])

        orders = []

        result.each do |record|
            orders << create_order_object(record)
        end

        return orders
    end

    def find_items_by_order_id(id)
        sql = 'SELECT items.id, items.item_name, items.item_price, items.item_quantity
                FROM items 
                    JOIN items_orders ON items_orders.item_id = items.id
                    JOIN orders ON items_orders.order_id = orders.id
                    WHERE orders.id = $1;'
        params = [id]
        result = DatabaseConnection.exec_params(sql, params)

        items = []

        result.each do |record|
            items << create_item_object(record)
        end

        return items
    end

    def find_items_by_customer_name(customer_name)
        sql = 'SELECT items.id, items.item_name, items.item_price, items.item_quantity
                FROM items 
                    JOIN items_orders ON items_orders.item_id = items.id
                    JOIN orders ON items_orders.order_id = orders.id
                    WHERE orders.customer_name = $1;'
        params = [customer_name]
        result = DatabaseConnection.exec_params(sql, params)

        items = []

        result.each do |record|
            items << create_item_object(record)
        end

        return items
    end

    def find_id_by_customer_name(customer_name)
        sql = 'SELECT * FROM orders WHERE orders.customer_name = $1;'
        params = [customer_name]
        cust = DatabaseConnection.exec_params(sql, params)
        cust_id = cust.first['id'].to_i
        return cust_id
    end
  
    def create(order)

        add_order_to_orders(order) if !all.any?{|record| record.customer_name == order.customer_name}
        join_order_to_items(order)
        return nil
    end
  
    private

    def create_order_object(record)
        order = Order.new
        order.id = record['id'].to_i
        order.customer_name = record['customer_name']
        order.order_date = record['order_date']
        return order
    end

    def create_item_object(record)
        item = Item.new
        item.id = record['id'].to_i
        item.item_name = record['item_name']
        item.item_price = record['item_price'].to_f
        item.item_quantity = record['item_quantity'].to_i
        return item
    end

    def add_order_to_orders(order)
        sql = 'INSERT INTO orders (customer_name, order_date) VALUES ($1, $2);'
        params = [order.customer_name, order.order_date]
        DatabaseConnection.exec_params(sql, params)
        return nil
    end

    def join_order_to_items(order)
        cust_id = find_id_by_customer_name(order.customer_name)
        order.items_to_buy.each do |record| 
            params = [record, cust_id]
            sql = 'INSERT INTO items_orders (item_id, order_id) VALUES ($1, $2);'
            DatabaseConnection.exec_params(sql, params)
        end
        return nil
    end
end