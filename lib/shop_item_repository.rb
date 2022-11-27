require_relative './shop_item'

class ShopItemRepository
  def all 
    shop_items = []

    sql = 'SELECT id, name, unit_price, quantity FROM shop_items;'
    sql_params = []
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    result_set.each do |record|
      shop_items << record_to_item_object(record)
    end
    return shop_items
  end

  def create(shop_item)
    
    sql = 'INSERT INTO shop_items (name, unit_price, quantity) VALUES($1, $2, $3);'
    sql_params = [shop_item.name, shop_item.unit_price, shop_item.quantity]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
  end

  def create_item_object(user_input_item_name)
    sql = 'SELECT id, name, unit_price, quantity FROM shop_items WHERE name = $1;'
    sql_params = [user_input_item_name]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]
    item = ShopItem.new 
    item.id = record['id']
    item.name = record['name']
    item.name = record['unit_price']
    item.quantity = record['quantity']

    return item
  end
  
  private 

  def record_to_item_object(record)
    shop_item = ShopItem.new 
    shop_item.id = record['id']
    shop_item.name = record['name']
    shop_item.unit_price = record['unit_price']
    shop_item.quantity = record['quantity']

    return shop_item
  end
end