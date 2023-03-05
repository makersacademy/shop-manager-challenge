require_relative "lib/item_repository"
require_relative "lib/order_repository"


class Application
  def initialize(database, io, repo1, repo2)
    DatabaseConnection.connect(database)  # database name might vary from a device to another
    @io = io
    @repo1 = repo1
    @repo2 = repo2
  end

  def interface
    @io.puts "Welcome to the shop manager program!"
    @io.puts ""
    @io.puts "What would you like to do?"
    @io.puts "1 - All the items"
    @io.puts "2 - Create an item"
    @io.puts "3 - All the orders"
    @io.puts "4 - Create an order"
  end

  def choice_1
    @io.puts "Here is a list of all the items in the shop."
    ItemRepository.new.all.each do |item|
      @io.puts "- ITEM #{item.id}: #{item.name}, PRICE EACH: £#{item.unit_price}, QUANTITY: #{item.quantity}."
    end
  end

  def choice_2
    new_item = Item.new
    @io.puts "What's the name of the item you want to add?"
    name = @io.gets.chomp
    @io.puts "What's the unit price of the new item?"
    price = @io.gets.chomp
    @io.puts "What's the quantity you have in store of that item?"
    quantity = @io.gets.chomp
    new_item.name,  new_item.unit_price,  new_item.quantity = name, price.to_i, quantity.to_i
    ItemRepository.new.create (new_item)
  end

  def choice_3
    @io.puts "Here is a list of all the order placed."
    OrderRepository.new.all.each do |order|
      @io.puts "ORDER #{order.id} - CUSTOMER: #{order.customer_name}, DATE: #{order.date}, ITEM_ID: #{order.item_id}."
    end
  end

  def choice_4
    new_order = Order.new
    @io.puts "What's the customer's name for this purchase?"
    name = @io.gets.chomp
    @io.puts "What's the date the purchase was made?"
    date = @io.gets.chomp
    @io.puts "What's the ID of the item purchased?"
    id = @io.gets.chomp
    new_order.customer_name, new_order.date, new_order.item_id = name, date, id.to_i
    OrderRepository.new.create(new_order)
  end

  def run
    interface
    choice = gets.chomp
    choice_1 if choice == "1"
    choice_2 if choice == "2"
    choice_3 if choice == "3"
    choice_4 if choice == "4"  
  end

end

if __FILE__ == $0
  app = Application.new(
    'shop',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
