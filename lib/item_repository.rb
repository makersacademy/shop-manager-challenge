require_relative '../lib/database_connection.rb'
require_relative '../lib/item.rb'
class ItemRepository

    def all

        query = "SELECT id, name, unit_price, quantity FROM items;"
        params = []
        result_set = DatabaseConnection.exec_params(query, params)
        items = []
        result_set.each do |record|
            item = Item.new
            item.id = record["id"]
            item.name = record["name"]
            item.unit_price = record["unit_price"]
            item.quantity = record["quantity"]

            items << item
        end
       items
    
    end

    def create(item)
        sql = 'INSERT INTO items (name, unit_price, quantity) VALUES($1, $2, $3);'
        sql_params = [item.name, item.unit_price, item.quantity]
        DatabaseConnection.exec_params(sql,sql_params)

    end
   
end

