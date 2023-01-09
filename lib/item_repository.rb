require_relative './item'


class ItemRepository

  # Selecting all records
  # No arguments
  def all
    sql ='SELECT id, name, unit_price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])

    items = []

    result_set.each do |record|
      items.push(record_to_item_object(record))
    end
    return items

  end

  def create(item)
    sql = 'INSERT INTO 
          items (name, unit_price, quantity)
            VALUES($1, $2, $3);'
    sql_params = [item.name, item.unit_price, item.quantity]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  private

  def record_to_item_object(record)
    item = Item.new

    item.id = record['id'].to_i
    item.name = record['name']
    item.unit_price = record['unit_price'].to_i
    item.quantity = record['quantity'].to_i

    return item
  end
end

