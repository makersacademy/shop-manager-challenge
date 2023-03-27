require_relative 'item'

class ItemRepository
    def all 
        sql = 'SELECT id, name, price, quantity FROM items;'
        results = DatabaseConnection.exec_params(sql, [])
        items = []
        results.each do |record|
            item = Item.new
            item.id = record['id']
            item.name = record['name']
            item.price = record['price']
            item.quantity = record['quantity']
            items << item
        end
        items
    end
end