require_relative 'item'

class ItemRepository
  def all
    sql = 'SELECT * FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])

    items = []

    result_set.each do |row|
      item = Item.new
      item.id = row['id'].to_i
      item.name = row['name']
      item.price = row['price'].to_f
      item.quantity = row['quantity'].to_i

      items << item
    end
    items
  end

  def create(item)
    sql = 'INSERT INTO items(name, price, quantity) VALUES ($1, $2, $3)'
    DatabaseConnection.exec_params(sql, [item.name, item.price, item.quantity])

  end

  def has_stock(id)
    # this query returns a dummy value if the criteria is met
    # if there is no match, no rows are returned.
    # I only want to know if it's going to return one row or not
    sql = 'SELECT id FROM items where id = $1 and quantity > 0;'
    result_set = DatabaseConnection.exec_params(sql, [id])

    return result_set.ntuples > 0
  end

end