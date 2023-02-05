require_relative 'item'

class ItemRepository
  def all
    # Executes the SQL query:
    sql = 'SELECT id, name, price, quantity FROM items;'
    sql_params = []

    item_set = DatabaseConnection.exec_params(sql, sql_params)

    items = []

    item_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.name = record['name']
      item.price = record['price']
      item.quantity = record['quantity']

      items << item 
    end 
    
    return items
    # Returns an array of item objects.
  end

  def find(id)
    sql = 'SELECT id, name, price, quantity FROM items WHERE id = $1'
    sql_params = [id]

    result_item = DatabaseConnection.exec_params(sql, sql_params)

    result_item = result_item[0]

    item = Item.new
    item.id = result_item['id']
    item.name = result_item['name']
    item.price = result_item['price']
    item.quantity = result_item['quantity']

    return item 

    # returns a single item 
  end 

  def create(item)
    # executes the SQL query: 
    sql = 'INSERT INTO items (name, price, quantity) VALUES($1, $2, $3);'
    sql_params = [item.name, item.price, item.quantity]

    DatabaseConnection.exec_params(sql,sql_params)

    # returns nothing 
  end
end 