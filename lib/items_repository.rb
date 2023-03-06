require 'item_model'

class ItemsRepository
  def all
    sql = 'SELECT id, item_name, item_price, item_quantity FROM items;'
    result = DatabaseConnection.exec_params(sql, [])
    items_list = []
    item = Item.new
    loop_records(result, item, items_list)
    return items_list
  end
  
  def find(id)
    sql = 'SELECT id, item_name, item_price, item_quantity FROM items WHERE id = $1;'
    result = DatabaseConnection.exec_params(sql, [id])
    record = result[0]
    item = Item.new
    item.id = record['id'].to_i
    item.item_name = record['item_name']
    item.item_price = record['item_price'].to_i
    item.item_quantity = record['item_quantity'].to_i
    return item
  end
  
  def create(item)
    sql = 'INSERT INTO items (item_name, item_price, item_quantity) VALUES ($1, $2, $3);'
    params = [item.item_name, item.item_price, item.item_quantity]
    result = DatabaseConnection.exec_params(sql, params)
    return nil
  end
  
  def update(item)
    sql = 'UPDATE items SET item_name = $1, item_price = $2, item_quantity = $3;'
    params = [item.item_name, item.item_price, item.item_quantity]
    result = DatabaseConnection.exec_params(sql, params)
    return nil
  end
  
  def delete(id)
    sql = 'DELETE FROM items WHERE id = $1;'
    result = DatabaseConnection.exec_params(sql, [id])
    return nil
  end

  private
  
  list = []
  def loop_records(result, item, list)
    result.each do |record|
      item = Item.new
      item.id = record['id'].to_i
      item.item_name = record['item_name']
      item.item_price = record['item_price'].to_i
      item.item_quantity = record['item_quantity'].to_i
      list << item
    end
    return list
  end
end
