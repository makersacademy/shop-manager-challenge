require 'item'

class ItemRepository
    def all

        items = []

        sql = 'SELECT id, name, price, quantity FROM items;'
        result = DatabaseConnection.exec_params(sql,[])

        item = Item.new
        result.each do |sql_data|

            item.id = sql_data['id']
            item.name = sql_data['name']
            item.price = sql_data['price']
            item.quantity = sql_data['quantity']
            
            items << item
        end
        return items
    end
end