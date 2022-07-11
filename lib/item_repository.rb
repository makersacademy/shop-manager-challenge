require_relative './item'

class ItemRepository
    def all
        sql = 'SELECT id, name, price, quantity FROM items'
        result_set = DatabaseConnection.exec_params(sql, [])
        items = []

        result_set.each do |record|
            item = Item.new
            item.id = record['id'].to_i
            item.name = record['name']
            item.price = record['price'].to_f
            item.quantity = record['quantity'].to_i
            items << item
        end

        return items
    end
    
    def find(id)
        sql = 'SELECT id, name, price, quantity FROM items WHERE id = $1'
        result_set = DatabaseConnection.exec_params(sql, [id])
        record = result_set[0]

        item = Item.new
        item.id = record['id'].to_i
        item.name = record['name']
        item.price = record['price'].to_f
        item.quantity = record['quantity'].to_i
        
        return item
    end

    def create(new_item)
        sql = "INSERT INTO 
                items (id, name, price, quantity) 
                VALUES ($1, $2, $3, $4)"
        params =  [
            new_item.id,
            new_item.name,
            new_item.price,
            new_item.quantity
        ]

        DatabaseConnection.exec_params(sql, params)
    end
end