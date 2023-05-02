require_relative './item'

class ItemRepository

    def all
        sql = 'SELECT id, name, unit_price, quantity FROM items;'
        result_set = DatabaseConnection.exec_params(sql, [])
        
        items =[]
        result_set.each do|record|
            # item = Item.new
            # item.id = record['id']
            # item.name = record['name']
            # item.unit_price= record['unit_price']
            # item.quantity= record['quantity']
            items << record_to_item_object(record)
        end
        return items

    end

    def record_to_item_object(record)
            item = Item.new
            item.id = record['id']
            item.name = record['name']
            item.unit_price= record['unit_price']
            item.quantity= record['quantity']
            return item
    end

 def create(item)
    sql = 'INSERT INTO items (name, unit_price, quantity) VALUES($1, $2, $3);'
    sql_params = [item.name, item.unit_price, item.quantity]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
 end

end