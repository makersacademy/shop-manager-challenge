require_relative './item'

class ItemsRepository
  def all
    sql = 'SELECT * FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    items = []
    result_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.item_name = record['item_name']
      item.price = record['price']
      item.quantity = record['quantity']
      items << item
    end
    return items
  end

  def find(id)
    sql = 'SELECT * FROM items WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
    item = Item.new
    item.id = record['id']
    item.item_name = record['item_name']
    item.price = record['price']
    item.quantity = record['quantity']
    return item
  end

  def create(new_item)
    sql = "INSERT INTO items (id, item_name, price, quantity) VALUES (
        $1, $2, $3, $4);"
    params = [new_item.id, new_item.item_name, new_item.price, new_item.quantity]
    result_set = DatabaseConnection.exec_params(sql, params)
    return nil
  end

  def delete(id_to_delete)
    sql = 'DELETE FROM items WHERE id = $1;'
    params = [id_to_delete]
    result_set = DatabaseConnection.exec_params(sql, params)
    return nil
  end
end