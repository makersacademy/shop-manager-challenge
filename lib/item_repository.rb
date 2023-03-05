require_relative 'item'

class ItemRepository
  # Creates instance varaible for kernel
  def initialize(terminal_io) # One argument - double
    @terminal_io = terminal_io
  end
  
  def list_all_items
    sql = 'SELECT * FROM items;'; items = DatabaseConnection.exec_params(sql, [])
    
    all_items = []

    items.each do |item|
      item_object = Item.new 
      item_object.id = item['id']; item_object.item_name = item['item_name'] 
      item_object.unit_price = item['unit_price']; item_object.quantity = item['quantity']
      all_items << item_object
    end

    all_items
  end

  def create_new_item
    @terminal_io.puts 'What is the name of the new item?'
    item_name = @terminal_io.gets.chomp

    @terminal_io.puts 'What is the unit price of the new item?'
    unit_price = @terminal_io.gets.chomp

    @terminal_io.puts 'What is the quantity of the new?'
    quantity = @terminal_io.gets.chomp

    sql = 'INSERT INTO items (item_name, unit_price, quantity) VALUES($1, $2, $3);'
    params = [item_name, unit_price, quantity]

    DatabaseConnection.exec_params(sql, params); @terminal_io.puts 'Item successfully created!'

    return nil
  end
end
