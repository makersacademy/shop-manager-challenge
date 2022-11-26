require_relative './item'
# id, name, unit_price, quantity

class ItemRepository

  def all
    sql = 'SELECT id, name, unit_price, quantity FROM items ORDER BY id;'
    result_set = DatabaseConnection.exec_params(sql, [])
    items = []
    result_set.each do |record|
      items << record_to_object(record)
    end
    return items
  end


  def create(item)
    # Executes the SQL query:
    sql = 'INSERT INTO items (id, name, unit_price, quantity) VALUES ($1, $2, $3, $4);'
    # here the new_item_id comes from a separate private method named new_item_id
    # feed the new_id in the sql_params
    sql_params = [new_item_id, item.name, item.unit_price, item.quantity]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    return puts "\nYour item has been successfully created.\n"
  end

# ================================================================
  private

  def record_to_object(record)
    object = Item.new
    object.id = record['id'].to_i
    object.name = record['name']
    object.unit_price = record['unit_price'].to_i
    object.quantity = record['quantity'].to_i
    return object
  end


  def new_item_id
    # query for the last id in the table
    last_id_query = 'SELECT MAX(id) FROM items;'
    last_id_result = DatabaseConnection.exec_params(last_id_query, [])

    new_id = nil
    # get the value of the last id
    last_id_result.each do |n|
      new_id =  n['max']
    end
    # new_id is being returned as a string so I convert it to an int
    # add one to the last id to create the new id
    new_id = Integer(new_id) + 1
    return new_id
  end

end
