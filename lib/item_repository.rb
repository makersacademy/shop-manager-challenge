require_relative 'item'

class ItemRepository
    def all
        items = []
        sql = 'SELECT id, name, price, quantity FROM items;'
        result = DatabaseConnection.exec_params(sql,[])

        result.each do |sql_data|
            item = Item.new
            item.id = sql_data['id']
            item.name = sql_data['name']
            item.price = sql_data['price']
            item.quantity = sql_data['quantity']
            
            items << item
        end
        return items
    end

    def find(id)

        sql = 'SELECT id, name, price, quantity FROM items WHERE id = $1;'
        params = [id]
        result = DatabaseConnection.exec_params(sql, params)

        find_id = result[0]

        item = Item.new
        item.id = find_id['id']
        item.name = find_id['name']
        item.price = find_id['price']
        item.quantity = find_id['quantity']
            
        return item
    end

    def create(item)
        sql = 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);'
        params = [item.name, item.price, item.quantity]
        result = DatabaseConnection.exec_params(sql, params)
    end
end