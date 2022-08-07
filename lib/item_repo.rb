require_relative 'item'
require_relative 'database_connection'

class ItemRepository
  def all
    sql = 'SELECT * FROM items;'
    result = DatabaseConnection.exec_params(sql, [])
    result.map { |record| make_item(record) }
  end

  def create(item)
    sql = 'INSERT INTO items (name, unit_price, qty)
      VALUES ($1, $2, $3);'

    params = [item.name, item.unit_price, item.qty]
    DatabaseConnection.exec_params(sql, params)
    return
  end

  # Update an item
  # Takes an Item object as an argument
  def update(item)
    # Executes the SQL query:
    # UPDATE items SET (id, name, unit_price, qty)
    # VALUES ($1, $2, $3, $4)
    
    # params = [item.id, item.name, item.unit_price, item.qty]
    # Returns nothing
  end

  private

  def make_item(record)
    item = Item.new
    item.id = record['id']
    item.name = record['name']
    item.unit_price = record['unit_price']
    item.qty = record['qty']
    item
  end
end