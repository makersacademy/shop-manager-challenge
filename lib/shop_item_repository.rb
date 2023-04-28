require_relative './shop_item'

class ShopItemRepository
  def all
    sql = 'SELECT id, name, unit_price, quantity FROM shop_items;'
    
    result_set = DatabaseConnection.exec_params(sql, [])

    shop_items = []
    result_set.each do |record|
      shop_items << create_shop_item(record)
    end
    return shop_items
  end

  def create(shop_item)
    sql = 'INSERT INTO shop_items (name, unit_price, quantity)
    VALUES ($1, $2, $3);'
    params = [shop_item.name, shop_item.unit_price, shop_item.quantity]

    DatabaseConnection.exec_params(sql, params)
  end

  def find(id)
    sql = 'SELECT id, name, unit_price, quantity FROM shop_items WHERE id = $1;'
    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)
    result = result_set[0]
    create_shop_item(result)
  end

  private

  def create_shop_item(record)
    shop_item = ShopItem.new
    shop_item.id = record['id']
    shop_item.name = record['name']
    shop_item.unit_price = record['unit_price']
    shop_item.quantity = record['quantity']
    return shop_item
  end
end
