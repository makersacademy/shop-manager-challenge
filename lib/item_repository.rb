require '../lib/item'

class ItemRepository
  def initialize(io)
    @io = io
  end

  def all
    query = 'SELECT * FROM items;'
    result = DatabaseConnection.exec_params(query, [])
    items = []
    result.each do |item|
      new_item = Item.new
      new_item.id = item['id']
      new_item.name = item['name']
      new_item.unit_price = item['unit_price']
      new_item.quantity = item['quantity']
      items << new_item
    end
    return items
  end

  def create
    @io.puts "What is the item name?"
    name = @io.gets.chomp
    @io.puts "What is the unit price?"
    unit_price = @io.gets.chomp.to_i
    @io.puts "How many in stock?"
    quantity = @io.gets.chomp.to_i
    query = 'INSERT INTO items (name, unit_price, quantity) VALUES($1, $2, $3);'
    params = [name, unit_price, quantity]
    DatabaseConnection.exec_params(query, params)
  end
end

