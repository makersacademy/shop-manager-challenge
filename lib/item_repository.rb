require_relative './item.rb'
require_relative './database_connection.rb'

class ItemRepository
    def all
        sql = 'SELECT * FROM items;'
        result = DatabaseConnection.exec_params(sql, [])

        items = []

        result.each do |record|
            items << create_item_object(record)
        end

        return items
    end

    def create(item)
        sql = 'INSERT INTO items (item_name, item_price, item_quantity) VALUES ($1, $2, $3)'
        params = [item.item_name, item.item_price, item.item_quantity]
        DatabaseConnection.exec_params(sql, params)
        return nil
    end

    def find_by_item_name(item_name)
        sql = 'SELECT * FROM items WHERE item_name = $1'
        params = [item_name]
        item = DatabaseConnection.exec_params(sql, params).first
        return create_item_object(item)
    end

    private

    def create_item_object(record)
        item = Item.new
        item.id = record['id'].to_i
        item.item_name = record['item_name']
        item.item_price = record['item_price'].to_f
        item.item_quantity = record['item_quantity'].to_i
        return item
    end
end
