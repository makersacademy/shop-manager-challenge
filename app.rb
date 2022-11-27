require_relative 'lib/database_connection'
require_relative 'lib/order_repository'
require_relative 'lib/item_repository'

class Application

  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run

    @results = []

    @io.puts "Welcome to the shop management program!"
    @io.puts "\n"
    @io.puts "What do you want to do?"
    @io.puts " 1 = list all shop items"
    @io.puts " 2 = list all items in an order"
    @io.puts " 3 = list all shop orders"
    @io.puts " 4 = list all orders containing an item"
    @io.puts "\n"
    @io.print "Enter your choice: "
    input = @io.gets.chomp
    @io.puts "\n"

    if input == "1"
    @item_repository.all.each do |record|
      record = "##{record.id} #{record.name} - Unit price: #{record.price} - Quantity: #{record.quantity}"

      process_results(record)
    end

    elsif input == "2"
      @io.puts "Enter item number:"
      item_id = @io.gets.chomp

      orders = @order_repository.find_by_item(item_id)

      orders.each do |record|
        record = "##{record['id']} #{record['customer_name']} - Order date: #{record['order_date']}"
   
        process_results(record)
      end

    elsif input == "3"
      @order_repository.all.each do |record|
      record = "##{record.id} #{record.customer_name} - Order date: #{record.order_date}"
  
      process_results(record)
      end

    elsif input == "4"
      @io.puts "Enter order number:"
      order_id = @io.gets.chomp

      items = @item_repository.find_by_order(order_id)

      items.each do |record|
        record = "##{record['id']} #{record['name']} - Unit price: #{record['price']} - Quantity: #{record['quantity']}"
   
        process_results(record)
      end
    end

    @results
  end

  private

  def process_results(record)
    puts record
    @results << record
  end

end

# item_repository = ItemRepository.new
# order_repository = OrderRepository.new
# app = Application.new('shop_items_orders_test', Kernel, item_repository, order_repository)

# app.run

