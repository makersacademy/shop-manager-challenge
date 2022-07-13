require_relative 'item'
require_relative 'database_connection'
class ItemRepository
  def initialize(io)
    @io = io
  end

  def all_items
    sql = 'SELECT * FROM items;'
    result_set = DatabaseConnection.exec_params(sql,[])
    items = []
    result_set.each do |result|
      new_item = assign_item(result)
      items << new_item
    end
    return items
  end

  def assign_item(result)
    item = Item.new
    item.id = result["id"].to_i
    item.name = result["name"]
    item.price = result["price"].to_f
    item.quantity = result["quantity"].to_i
    return item
  end

  def add_item
    @io.puts "Add item"
    params = item_info
    sql = 'INSERT INTO items ("id", "name", "price", "quantity")
     VALUES ($1, $2, $3, $4);'
    DatabaseConnection.exec_params(sql, params)
    @io.puts "Item added!"
    return nil
  end

  def item_info
    new_item = Item.new
    @io.puts "What is the item id?"
    item_id = @io.gets.to_i
    @io.puts "What is the item name?"
    item_name = @io.gets.chomp
    @io.puts "What is the item price?"
    item_price = @io.gets.to_f
    @io.puts "How many do you have to sell?"
    item_quantity = @io.gets.to_i
    return params = [item_id, item_name, item_price, item_quantity]
  end
end
