require_relative './item'

class ItemRepository
    def all
        # shows all items
        sql = 'SELECT id, name, price, quantity FROM items;'
        result = DatabaseConnection.exec_params(sql, [])

        items = []

        result.each do |record|
            item = Item.new
            item.id = record['id']
            item.name = record['name']
            item.price = record['price']
            item.quantity = record['quantity']

            items << item
        end
        return items
    end

    def find(id)
        sql = 'SELECT id, name, price, quantity FROM items WHERE id = $1;'
        sql_params = [id]

        result = DatabaseConnection.exec_params(sql, sql_params)

        record = result[0]

        item = Item.new
        item.id = record['id']
        item.name = record['name']
        item.price = record['price']
        item.quantity = record['quantity']

        return item

    end

    def create(item)
        sql = 'INSERT INTO items
                    (name, price, quantity)
                    VALUES($1, $2, $3);'
        sql_params = [item.name, item.price, item.quantity]

        DatabaseConnection.exec_params(sql, sql_params)

        return nil
    end

    def delete(id)
        sql = 'DELETE FROM items
                    WHERE id = $1;'
        sql_params = [id]

        DatabaseConnection.exec_params(sql, sql_params)

        return nil
    end


end