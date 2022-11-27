require_relative './item'
require_relative './database_connection'

class ItemRepository

  def all
    sql = 'SELECT id, name, unit_price, quantity 
            FROM items;'
    result_set = DatabaseConnection.exec_params(sql,[])

    items = []
    result_set.each do |record|
      items << record_to_item_object(record)
    end

    return items
  end


  def create(item)
    sql = 'INSERT INTO items 
            (name, unit_price, quantity) 
            VALUES($1, $2, $3);'
    params = [item.name, item.unit_price, item.quantity]

    DatabaseConnection.exec_params(sql, params)

    return nil
  end

  private

  def record_to_item_object(record)
    item = Item.new
    item.id = record["id"].to_i
    item.name = record["name"]
    item.unit_price = record["unit_price"].gsub("$","£")
    item.quantity = record["quantity"].to_i

    return item
  end

end