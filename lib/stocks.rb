require 'database_connection'

class StockItem #NOTE THIS IS NOT USED BY PROGRAM
    attr_accessor :id, :item_name, :stock_level, :unit_price
end

class StockItemsRepo

    def show_all_stock
        sql = "select item_name, unit_price, stock_level from stock_items"
        result = DatabaseConnection.exec_params(sql,[])
        fail "no results" unless result.ntuples>0
        result.values
    end

    def delete_stock(item_id)
        sql1 = "delete from stock_items_orders where stock_item_id = $1"
        DatabaseConnection.exec_params(sql1,[item_id])
        sql2 = "delete from stock_items where id = $1"
        DatabaseConnection.exec_params(sql2,[item_id])
    end

    def add_new_item(name, number, price)
        sql = "insert into stock_items (item_name, stock_level, unit_price)"\
        "Values ($1,$2,$3)"
        DatabaseConnection.exec_params(sql,[name,number,price])
    end

    def view_customers_who_bought(item)
        sql = "select item_name, customer_name, order_date from stock_items
        inner join stock_items_orders on stock_items.id = stock_items_orders.stock_item_id
        inner join orders on stock_items_orders.order_id = orders.id
        inner join customer_orders on orders.customer_order_id = customer_orders.id
        where item_name = $1"
        results = DatabaseConnection.exec_params(sql,[item])
    end

end