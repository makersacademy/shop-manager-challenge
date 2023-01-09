require_relative './item'

class ItemRepository

   
    def all
        sql = 'SELECT id, name, unit_price, quantity FROM items;'
        params = []

        items = []

        result_set = DatabaseConnection.exec_params(sql, params)
        result_set.each do |record|
            item = Item.new
            item.id = record['id'].to_i
            item.name = record['name']
            item.unit_price = record['unit_price'].to_i
            item.quantity = record['quantity'].to_i

            items << item
        end
        
        return items
    end

   
    def find(id)
        sql = 'SELECT id, name, unit_price, quantity FROM items WHERE id = $1;'
        params = [id]
        
        result_set = DatabaseConnection.exec_params(sql, params)
        record = result_set[0]

        item = Item.new
        item.id = record['id'].to_i
        item.name = record['name']
        item.unit_price = record['unit_price'].to_i
        item.quantity = record['quantity'].to_i

        return item
    end

    def create(item)
        sql = 'INSERT into items (name, unit_price, quantity) VALUES ($1, $2, $3);'
        params = [item.name, item.unit_price, item.quantity]

        result_set = DatabaseConnection.exec_params(sql, params)
    end

    def increase_stock(id)
        sql = 'UPDATE items SET quantity = quantity + 10 WHERE id = $1;'
        params = [id]

        DatabaseConnection.exec_params(sql, params)
    end
end