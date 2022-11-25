require_relative './shop_item'

class ShopItemRepository
  def all 
    shop_items = []

    sql = 'SELECT id, name, unit_price, quantity FROM shop_items;'
    sql_params = []
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    result_set.each do |record|
      shop_items << record_to_object(record)
    end
    return shop_items
  end

  def create(shop_item)
    
    sql = 'INSERT INTO shop_items (name, unit_price, quantity) VALUES($1, $2, $3);'
    sql_params = [shop_item.name, shop_item.unit_price, shop_item.quantity]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
  end
  
  private 

  def record_to_object(record)
    shop_item = ShopItem.new 
    shop_item.id = record['id']
    shop_item.name = record['name']
    shop_item.unit_price = record['unit_price']
    shop_item.quantity = record['quantity']

    return shop_item
  end
end