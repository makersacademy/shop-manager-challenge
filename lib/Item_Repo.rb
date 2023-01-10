require 'Item'


class Items_Repo

    def all
        list = []
        sql = 'SELECT id, name, price, quantity FROM items;'
        result_set = DatabaseConnection.exec_params(sql, [])
        result_set.each do |record|
          items = Items.new
          items.id = record['id']
          items.name = record['name']
          items.price = record['price']
          items.quantity = record['quantity']
          list << items
        end
      return list
    end

    def create(item)
        sql = 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);'
        sql_params = [item.name, item.price, item.quantity]
        result_set = DatabaseConnection.exec_params(sql, sql_params)
        return nil
    end
end 