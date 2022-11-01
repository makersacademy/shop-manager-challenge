# frozen_string_literal: false
require_relative './item'
# Repository class
# (in lib/item_repository.rb)
class ItemRepository
  # Selecting all records
  # No arguments
  def list
    sql = 'SELECT id, item_name, price, order_id FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])

    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.item_name = record['item_name']
      item.price = record['price']
      item.order_id = record['order_id']
      items << item
    end

    items
  end

  # Create a new item
  # One argument: Item object
  def create(item)
    sql = 'INSERT INTO items (item_name, price) VALUES($1,$2);'
    sql_params = [item.item_name, item.price]
    DatabaseConnection.exec_params(sql, sql_params)

    nil
  end
end
