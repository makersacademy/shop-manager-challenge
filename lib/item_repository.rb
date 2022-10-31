require_relative './item'

class ItemRepository
  def all_item
    sql = 'SELECT id, name, price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql,[])
    
    all_item = []
    result_set.each do |record|
      all_item << get_item_record(record)
    end
    return all_item
  end
  
  def create_item(item)
    sql = 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);'
    sql_params = [item.name, item.price, item.quantity]

    DatabaseConnection.exec_params(sql, sql_params)
    
    return nil
  end

  private 

  def get_item_record(record)
    item = Item.new
    item.id = record['id'].to_i
    item.name = record['name']
    item.price = record['price'].to_i
    item.quantity = record['quantity'].to_i
    return item
  end 
end
