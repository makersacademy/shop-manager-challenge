require "item"

class ItemRepository

  def all
    sql_query = 'SELECT id, name, unit_price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql_query,[])
    result_set.map { |record| record_to_item(record) }
    
    # items = []
    # result_set.each do |record|
    #   item = Item.new
    #   item.id = record['id'].to_i
    #   item.name = record['name']
    #   item.unit_price = record['unit_price']
    #   item.quantity = record['quantity']
    #   items << item
    # end
    # return items
  end

  def find(id)
    sql_query = 'SELECT id, name, unit_price, quantity FROM items WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql_query,params)[0]

    item = Item.new
    item.id = result_set['id'].to_i
    item.name = result_set['name']
    item.unit_price = result_set['unit_price']
    item.quantity = result_set['quantity']

    return item

  end

  def create(item)
    sql_query = 'INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);'
    params = [item.name,item.unit_price,item.quantity]
    DatabaseConnection.exec_params(sql_query,params)
  end

  def delete(id)
    sql_query = 'DELETE FROM items WHERE id = $1;'
    params = [id]
    DatabaseConnection.exec_params(sql_query,params)
  end

  def update(item)
    sql_query = 'UPDATE items SET name = $1, unit_price = $2, quantity = $3 WHERE id = $4;'
    params = [item.name, item.unit_price, item.quantity, item.id]
    DatabaseConnection.exec_params(sql_query, params)
  end

  private 

  def record_to_item(record)
    item = Item.new
    item.id = record['id'].to_i
    item.name = record['name']
    item.unit_price = record['unit_price']
    item.quantity = record['quantity']
    return item
  end
end
