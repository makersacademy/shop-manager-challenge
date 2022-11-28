require_relative "../lib/item"
require_relative "../lib/order"
require_relative "../lib/database_connection"

class ItemRepository
  def all
    sql = "SELECT id, item_name, item_price, item_quantity FROM items;"
    result_set = DatabaseConnection.exec_params(sql, [])
    all_items_list = []

    result_set.each do |item|
      item_all = Item.new
      item_all.id = item["id"]
      item_all.item_name = item["item_name"]
      item_all.item_price = item["item_price"]
      item_all.item_quantity = item["item_quantity"]

      all_items_list << item_all
    end

    return all_items_list
  end

  def find(id)
    sql = "SELECT id,item_name,item_price,item_quantity FROM items WHERE id = $1;"
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]

    item_one = Item.new
    item_one.id = record["id"]
    item_one.item_name = record["item_name"]
    item_one.item_price = record["item_price"]
    item_one.item_quantity = record["item_quantity"]

    return item_one
  end

  def create(new_item)
    sql = "INSERT INTO items (item_name,item_price,item_quantity) VALUES ($1,$2,$3);"
    sql_params = [new_item.item_name, new_item.item_price, new_item.item_quantity]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end

  def update(item)
    sql = "UPDATE items SET item_name = $1, item_price = $2, item_quantity = $3 WHERE id = $4;"
    sql_params = [item.item_name, item.item_price, item.item_quantity, item.id]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end
end
