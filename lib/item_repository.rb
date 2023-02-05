require_relative './item'
require './app'

class ItemRepository
    def all
      sql = 'SELECT * FROM items;'
      result = DatabaseConnection.exec_params(sql, [])
      items = []
      result.each do |record|
        item = Item.new
        item.id = record['id']
        item.name = record['name']
        item.price = record['price']
        item.quantity = record['quantity']
        items.push(item)
      end
    return items
    end
    
    def find(id)
        sql = 'SELECT id, name, price, quantity FROM items WHERE id = $1'
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

    def create(new_item)
        sql = 'INSERT INTO items(id, name, price, quantity) VALUES ($1, $2, $3, $4);'
        sql_params = [new_item.id, new_item.name, new_item.price, new_item.quantity]
        result = DatabaseConnection.exec_params(sql, sql_params)
        return nil
    end
end