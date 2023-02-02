require 'item'

class ItemRepository
  def all
    sql = 'SELECT id, name, price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql,[])

    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record['id'].to_i
      item.name = record['name']
      item.price = record['price']
      item.quantity = record['quantity'].to_i

      items << item
    end

    return items
  end

  def create(item)
    sql = 'INSERT INTO items (name,price,quantity) VALUES ($1,$2,$3);'
    params = [item.name, item.price, item.quantity]

    DatabaseConnection.exec_params(sql,params)

    return nil
  end
end
