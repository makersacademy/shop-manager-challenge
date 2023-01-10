require "./lib/database_connection"
require "./lib/order_repository"
require "./lib/item_repository"

class Application 
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end    

  def run
    @io.puts "Welcome to the shop management program!"
    @io.puts ""
    @io.puts "What do you want to do?"
    @io.puts "  1 = list all shop items"
    @io.puts "  2 = create a new item"
    @io.puts "  3 = list all orders"
    @io.puts "  4 = create a new order"
    @io.puts ""
    command = @io.gets.chomp
    @io.puts ""

    case command
    when '1'
      @io.puts "Here's a list of all shop items:"
      @item_repository.all.each do |record|
        @io.puts " ##{record.id} #{record.item_name} - Unit price: #{record.unit_price} - Quantity: #{record.quantity}"
      end 
    when '2' 
        # TODO; handle item create 
    when '3'
      @io.puts "Here's a list of all shop orders:"
      @order_repository.all.each do |record|
        @io.puts " ##{record.id} #{record.customer_name} - Order date: #{record.order_date} - Item: #{record.item_name}"
      end
    when '4' 
        # TODO; handle order create
    end 
  end 
end 

if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
