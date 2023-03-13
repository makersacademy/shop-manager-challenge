require "item"
require "order"
require "item_repository"
require "order_repository"

class Greeter
  def initialize(io)
    @io = io
  end

  def greet
    @io.puts "What do you want to do?"
    @io.puts "1 = list all shop items" 
    @io.puts "2 = create a new item"
    @io.puts "3 = list all orders"
    @io.puts "4 = create a new order"
    answer = @io.gets.chomp
    # items = ItemRepository.all
    # repo = ItemRepository.new    
    
    if answer == "1"
      repo = ItemRepository.new
      items = repo.all
      @io.puts "Here's a list of all shop items: "
      items.each do |item|
        @io.puts"##{item.id} #{item.name} - price: #{item.price} - quantity: #{item.quantity}"
      end
    # elsif answer == "2"
    #   repo = ItemRepository.new
    #   # item = repo.create(Item.new)#(Item.new(name: "Chocolate", price: 10, quantity)
    #   @io.puts "Please input the name of the new item"
    #   input_name = @io.gets.chomp
    #   # new_name = item(name: input_name)
    #   @io.puts "Please input the price of the new item"
    #   input_price = @io.gets.chomp.to_i
    #   @io.puts "Please input the quantity of the new item"
    #   input_quantity = @io.gets.chomp.to_i
    #   new_item = Item.new(input_name, input_price, input_quantity)
    #   repo.create(new_item)
    #   @io.puts "New item has been created with id: #{new_item.id}"
      elsif answer == "3"
        repo = OrderRepository.new
        orders = repo.all
        @io.puts "Here's a list of all orders: "
        orders.each do |order|
          @io.puts"##{order.id} #{order.customer_name}, made on #{order.date}"
        end
      else 
        @io.puts "Invalid input, please try again"
      end

  end  
  
end
