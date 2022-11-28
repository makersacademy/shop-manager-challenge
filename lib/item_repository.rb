require_relative './item'

class ItemRepository
    def all
        result = DatabaseConnection.exec_params('SELECT id, item, price, quantity, order_id FROM items;', [])

        all_items = []

        result.each do |record|
            new_item = Item.new
            new_item.id = record['id'].to_i
            new_item.item = record['item']
            new_item.price = record['price']
            new_item.quantity = record['quantity'].to_i
            new_item.order_id = record['order_id']

            all_items << new_item
        end
        return all_items
    end

    def create
        puts "Enter an item"
        new_item = gets.chomp
        puts "Enter price"
        new_price = gets.chomp
        puts "Enter quantity"
        new_quantity = gets.chomp
        new_quantity.to_i

        sql = 'INSERT INTO items (item, price, quantity) VALUES ($1, $2, $3);'
        sql_params = [new_item, new_price, new_quantity]
        repo = ItemRepository.new
        
        DatabaseConnection.exec_params(sql, sql_params)

        return nil
    end
end