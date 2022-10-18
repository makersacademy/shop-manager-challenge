# order repository class

require 'date'
require_relative './order'

class OrderRepository

    def all

        export = []
        # uses join so that the item is specified by name
        # and not just by the ID
        query = DatabaseConnection.exec_params(
            "SELECT orders.id, items.name, orders.customername, orders.date
            FROM orders
            INNER JOIN items ON orders.item=items.id;",
            []
        )
        query.each do |order|
            ord = Order.new
            ord.id = order["id"]
            ord.item = order["name"]
            ord.customername = order["customername"]
            ord.date = Time.at(order["date"].to_i)
            export.append(ord)
        end
        return export

    end

    def create(order)

        DatabaseConnection.exec_params(
            "INSERT INTO orders (item,customername,date) VALUES ($1,$2,$3)",
            [
                order.item,
                order.customername,
                DateTime.now.strftime('%s')
            ]
        )
        return order

    end

    def delete(id)

        DatabaseConnection.exec_params(
            "DELETE FROM orders WHERE id=$1",
            [id]
        )

    end

    def find(value,column)

        fail "Invalid column!" if (column!="item" && column!="id" && column!="customername")

        order = DatabaseConnection.exec_params(
            "SELECT * FROM orders WHERE #{column}=$1;",
            [value]
        )[0]
        
        ord = Order.new
        ord.id = order["id"]
        ord.item = order["item"]
        ord.customername = order["customername"]
        ord.date = Time.at(order["date"].to_i)
        
        return ord

    end

end