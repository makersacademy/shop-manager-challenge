
require_relative 'item'
require_relative 'database_connection'

class ItemRepository
  def all
    sql = '
            SELECT *
            FROM items;
          '
    result_set = DatabaseConnection.exec_params(sql, [])

    items = []

    result_set.each{
      |record|
      item = Item.new
      item.item_name = record['item_name']
      item.unit_price = record['unit_price']
      item.quantity = record['quantity']

      items.push(item)
    }

    items
  end

  def find(item_id)
    sql = '
            SELECT *
            FROM items
            WHERE id = $1;
          '
    record = DatabaseConnection.exec_params(sql, [item_id])[0]

    item = Item.new
    item.item_name = record['item_name']
    item.unit_price = record['unit_price']
    item.quantity = record['quantity']

    item
  end

  def create(new_item)
    sql = '
            INSERT INTO items (item_name, unit_price, quantity)
            VALUES($1,$2,$3);
          '
    DatabaseConnection.exec_params(sql, [new_item.item_name, new_item.unit_price, new_item.quantity])
  end
end