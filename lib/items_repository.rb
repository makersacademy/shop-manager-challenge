require 'items'
require 'database_connection'

class ItemRepository

def list_all
    sql = 'SELECT * FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])

    items = []

    result_set.each do |record|
        item = Item.new
        item.item_name = record['item_name']
        item.price = record['price']
        item.quantity = record['quantity']
        items << item
    end
    return items
end

def select_item(item_id)
    sql = 'SELECT * FROM items WHERE item_id = $1;'
    result_set = DatabaseConnection.exec_params(sql, [item_id])
    record = result_set.first
    item = Item.new
    item.item_name = record['item_name']
    item.price = record['price']
    item.quantity = record['quantity']
    return item
end

def create(item)
    sql = "INSERT INTO items (item_name, price, quantity) VALUES($1, $2, $3);"
    DatabaseConnection.exec_params(sql, [item.item_name, item.price, item.quantity])
end

end