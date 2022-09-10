require_relative 'item'

class ItemRepository
    def all
        items = []
        sql = 'SELECT id, stock, name, price, order_id FROM items;'
        result = DatabaseConnection.exec_params(sql, [])
   
        result.each do |it|
            item = Item.new
            item.id = it['id']
            item.stock = it['stock']
            item.name = it['name']
            item.price = it['price']
            item.order_id = it['order_id']
            items << item
        end
        items
    end
    def create(item)
        sql = 'INSERT INTO items (stock, name, price, order_id) VALUES ($1, $2, $3, $4);'
        params = [item.stock, item.name, item.price, item.order_id]

        DatabaseConnection.exec_params(sql, params)
    end
end