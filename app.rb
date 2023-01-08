require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/items'
require_relative 'lib/order'

DatabaseConnection.connect('shop_test')

class App
  def initialize(database_name, io, repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = repository
  end

  def run
    @io.puts 'Welcome to the shop management program!'
    @io.puts 'What do you want to do?'
    @io.puts '1 = list all shop items'
    @io.puts '2 = create a new item'
    @io.puts '3 = list all orders'
    @io.puts '4 = create a new order'
    choice = @io.gets.chomp

    if choice == '1'
      @io.puts "Here's a list of all shop items:"
      items = ItemRepository.new
      items.all_items.each do |item|
        @io.puts "##{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
      end
    elsif choice == '2'
      @io.puts 'Create a new item'
      @io.puts 'Add the name of the item now'
      item_name = @io.gets.chomp
      @io.puts 'Add the unit price of the item now'
      unit_price = @io.gets.chomp
      @io.puts 'Add the quantity of the item now'
      quantity = @io.gets.chomp
      items = ItemRepository.new
      items.add_item(item_name, unit_price, quantity)
      @io.puts 'Item added.. displaying updated list now...'
      items.all_items.each do |item|
        @io.puts "##{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
      end
    elsif choice == '3'
      @io.puts "Here's a list of all shop orders:"
      items = ItemRepository.new
      items.all_orders.each do |order|
        @io.puts "##{order.id} Order name: #{order.cust_name} - Product ordered: #{order.product_name} - Date: #{order.date}"
      end
    elsif choice == '4'
      @io.puts 'Create a new order'
      @io.puts 'Add the name of the customer making the order now'
      cust_name = @io.gets.chomp
      @io.puts 'Add the product name for the order now'
      product_name = @io.gets.chomp
      @io.puts 'Add the product id for the order now'
      product_id = @io.gets.chomp
      @io.puts 'Add the date of the order now'
      date = @io.gets.chomp
      items = ItemRepository.new
      items.add_order(cust_name, product_name, product_id, date)
      @io.puts 'Order added.. displaying updated list now...'
      items.all_orders.each do |order|
        @io.puts "##{order.id} Order name: #{order.cust_name} - Product ordered: #{order.product_name} - Date: #{order.date}"
      end
    end
  end
end

if __FILE__ == $0
  app = App.new('shop_test', Kernel, ItemRepository.new)
  app.run
end
