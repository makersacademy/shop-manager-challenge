require 'database_connection'


class Order #NOTE THIS IS NOT USED BY PROGRAM
    attr_accessor :id, :customer_name, :order_date 
end

class OrderItem #NOTE THIS IS NOT USED BY PROGRAM
    attr_accessor :id, :customer_order_id, :stock_item_ordered_id, :stock_item_ordered_qty 
end


class OrdersRepo

    def show_customer_orders
       sql = "select * from customer_orders order by order_date desc"
       DatabaseConnection.exec_params(sql,[]).values
    end

    def show_order_details
        sql = "select customer_name, order_date, item_name, unit_price,
        stock_item_ordered_qty from stock_items
        inner join stock_items_orders on stock_items.id = stock_items_orders.stock_item_id
        inner join orders on stock_items_orders.order_id = orders.id
        inner join customer_orders on orders.customer_order_id = customer_orders.id"
        results = DatabaseConnection.exec_params(sql,[]).values
    end

    def show_order_details_single(customer_name)
        sql = "select customer_name, order_date, item_name, stock_item_ordered_qty,
        stock_item_ordered_qty from stock_items
        inner join stock_items_orders on stock_items.id = stock_items_orders.stock_item_id
        inner join orders on stock_items_orders.order_id = orders.id
        inner join customer_orders on orders.customer_order_id = customer_orders.id
        where customer_name = $1"

        results = DatabaseConnection.exec_params(sql,[customer_name])
        
    end


    def add_new_order(name, date, item_ordered, qty_ordered)
        sql1 = "insert into customer_orders (customer_name, order_date) values ($1, $2)"
        DatabaseConnection.exec_params(sql1,[name,date])

        sql2 = "select max(id) from customer_orders where customer_name = $1"
        sql2res = DatabaseConnection.exec_params(sql2,[name]).values[0].join.to_i

        sql3 = "insert into orders (customer_order_id, stock_item_ordered_id,
        stock_item_ordered_qty) values ($1,$2,$3)"
        DatabaseConnection.exec_params(sql3,[sql2res,item_ordered, qty_ordered])

        sql4 = "select max(orders.id) from orders inner join customer_orders on orders.customer_order_id 
        = customer_orders.id where customer_name = $1"
        sql4res = DatabaseConnection.exec_params(sql4,[name]).values[0].join.to_i
        
        sql5 = "insert into stock_items_orders (stock_item_id, order_id) values ($1, $2)"
        DatabaseConnection.exec_params(sql5,[item_ordered,sql4res])
    end

end