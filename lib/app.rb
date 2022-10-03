require_relative "../lib/item_repository.rb"
require_relative "../lib/database_connection.rb"
# require_relative "../lib/item.rb"
# require_relative "../lib/order.rb"

class Application
  def initialize(io)
    @io = io
    DatabaseConnection.connect('shop_manager')
  end

  def run
    @io.puts "Welcome to the shop management program!"
    @io.puts ""
    @io.puts "What do you want to do?"
    @io.puts "  1 = list all shop items"
    @io.puts "  2 = create a new item"
    @io.puts "  3 = list all orders"
    @io.puts "  4 = create a new order"
    choice = @io.gets

    case choice
    when "1\n"
      self.list_all_items
    when "2\n"
      self.create_item
    when "3\n"
      self.list_all_orders 
    when "4\n"
      self.create_order
    end 
  end

  def list_all_items
    @io.puts "Here's a list of all shop items:"
    repo = ItemRepository.new
    items_list = repo.all_items
    items_list.each do |item|
      @io.puts "#{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
    end
  end
    
  def create_item
    @io.puts "Please, enter the name of the item you would like to create:"
    item_name = @io.gets
    @io.puts "Please, enter the unit price for this item:"
    item_price = @io.gets
    @io.puts "Please, enter the quantity for this item:"
    item_quantity = @io.gets
    @io.puts "Your item has been created successfully."
    repo = ItemRepository.new
    item = Item.new
    item.name = item_name.chomp
    item.unit_price = item_price.chomp
    item.quantity = item_quantity.chomp
    repo.create_item(item)
  end
  
  def list_all_orders
    @io.puts"Here is a list of all orders:"
    repo = ItemRepository.new
    orders_list = repo.all_orders
    orders_list.each do |order|
      @io.puts "#{order.id} Customer name: #{order.customer_name} - Date: #{order.date} - Item id: #{order.item_id}"
    end
  end

  def create_order
    @io.puts "Please, enter the customer name for the order:"
    order_customer_name = @io.gets
    @io.puts "Please, enter the date for this order:"
    order_date = @io.gets
    @io.puts "Please, enter the item id for this order:"
    item_id = @io.gets
    @io.puts "Your order has been created successfully."
    repo = ItemRepository.new
    order = Order.new
    order.customer_name = order_customer_name.chomp
    order.date = order_date.chomp
    order.item_id = item_id.chomp
    repo.create_order(order)
  end
end

app = Application.new(Kernel)
app.run