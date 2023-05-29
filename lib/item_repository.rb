require_relative './item'

class ItemRepository
  # Selecting all items
  # No arguments
  def all
    items = []
    # defining sql query string
    sql = 'SELECT id, name, unit_price, quantity FROM items;'
    # executes sql query and passes sql string and an empty array as an argument
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |inst|
      # for each instance it creates a new instance and assigns corresponding atributes
      items << item_result(inst)
    end

    return items
  end

  def find(id)
    sql = 'SELECT id, name, unit_price, quantity FROM items WHERE id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
  
    if result.ntuples.zero?
      return nil
    else
      return item_result(result[0])
    end
  end

  def create(item)
    
    sql = 'INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);'
    params = [item.name, item.unit_price, item.quantity]

    DatabaseConnection.exec_params(sql, params)

    return nil

  end

  def delete(id)
    sql = 'DELETE FROM items WHERE id = $1;'
    sql_params = [id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def update(item)
    # Executes the SQL;
    sql = 'UPDATE items SET name = $1, unit_price = $2, quantity = $3 WHERE id = $4;'
    params = [item.name, item.unit_price, item.quantity, item.id]

    DatabaseConnection.exec_params(sql, params)

    return nil
  end

  private

  def item_result(inst)
    item = Item.new

    item.id = inst['id']
    item.name = inst['name']
    item.unit_price = inst['unit_price']
    item.quantity = inst['quantity']

    return item
  end
end
