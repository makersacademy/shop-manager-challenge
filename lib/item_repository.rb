require 'item'

class ItemRepository
    def all
        
        sql = 'SELECT id, name, price, quantity FROM items;'
        result_set = DatabaseConnection.exec_params(sql, [])
        items = []

        result_set.each do |record|
            item = Item.new
            item.id = record['id'].to_i
            item.name = record['name']
            item.price = record['price'].to_i
            item.quantity = record['quantity'].to_i
            items << item
        end
            return items
    end

    def find(id)
        sql = 'SELECT id, name, price, quantity FROM items WHERE id = $1;'
        params = [id]
        result_set = DatabaseConnection.exec_params(sql, params)
        record = result_set[0]

        item = Item.new
        item.id = record['id'].to_i
        item.name = record['name']
        item.price = record['price'].to_i
        item.quantity = record['quantity'].to_i
        return item
    end

    def create(item)
        sql = 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);'
        sql_params = [item.name, item.price, item.quantity]
        DatabaseConnection.exec_params(sql, sql_params)
        return nil
    end
end