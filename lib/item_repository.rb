require_relative './items'

class ItemRepository

  def all
    items = []
    sql = 'SELECT id, name, price, qty FROM items;'
    item_set = DatabaseConnection.exec_params(sql, [])

    item_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.name = record['name']
      item.price = record['price']
      item.qty = record['qty']

      items << item
    end
    return items  
  end

  # def create(item)
  # # INSERT INTO items (name, price, qty) VALUES ($1, $2, $3);
  # # No return, just creates new Item object
  # end

end