require 'items'
class ShopRepository
  def all_items
    sql = 'SELECT * FROM items'
    repo = DatabaseConnection.exec_params(sql, [])
    items =
      repo.map do |each_item|
        item = Item.new
        item.id = each_item['id']
        item.name = each_item['name']
        item.unit_price = each_item['unit_price']
        item.quantity = each_item['quantity']
      end
    items
  end

  def add_item
  end

  def all_orders
  end

  def add_orders
  end
end
