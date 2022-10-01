require_relative '../lib/item'

class ItemRepository
    def all
        items = []

        sql = 'SELECT * FROM items;'
        result_set = DatabaseConnection.exec_params(sql, [])
        result_set.each do |record|
            new_item = Item.new
            new_item.id = record['id']
            new_item.quantity= record['quantity']
            new_item.name = record['name']
            new_item.unit_price = record['unit_price']
            

            items << new_item
        end
        return items
    end

    def view_items
        self.all.each do |item|
            p("*Item ID: #{item.id}, quantity: #(item.quantity}, #{item.name}, #Unit Price: $#(item.unit_price}*")
        end
    end

    def create(quantity, name, unit_price)
        sql = 'INSERT INTO items (id, quantity, name, unit_price) VALUES($1, $2, $3, $4);'
        id  = self.all.length + 1
        sql_params = [id, quantity, name, unit_price]
        DatabaseConnection.exec_params(sql, sql_params)
    end



    def find_item(item_id)
        sql = 'SELECT name FROM items WHERE id = $1;'
        sql_params = [item_id]
        
        result_set = DatabaseConnection.exec_params(sql, sql_params)
        return result_set[0]['name']
    end

    def amount
        self.all.length
    end
end