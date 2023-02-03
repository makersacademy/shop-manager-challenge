require_relative './lib/database_connection'
require_relative './lib/item_repository'
require_relative './lib/order_repository'
require_relative './lib/item'
require_relative './lib/order'
class Application
  def initialize(database_name, io, item_repo, order_repo)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repo = item_repo
    @order_repo = order_repo
  end

  def run
    @io.puts('Welcome to the shop management program!')
    @io.puts("\n")
    @io.puts('What do you want to do?')
    @io.puts('  1 = list all shop items')
    @io.puts('  2 = create a new item')
    @io.puts('  3 = list all orders')
    @io.puts('  4 = create a new order')
    @io.puts('  5 = exit')
    option = @io.gets.chomp

    if option == '1'
      @io.puts("Here's a list of all shop items:")
      @io.puts("\n")
      @item_repo.all.each do |item|
        @io.puts(" ##{item.id} #{item.name} - Unit price: #{item.price} - Quantity: #{item.quantity}")
      end
    elsif option == '2'
      new_item = Item.new
      @io.puts('What is the new item name?')
      new_item.name = @io.gets.chomp
      @io.puts('How much is it?')
      new_item.price = @io.gets.to_i
      @io.puts('How many in stock?')
      new_item.quantity = @io.gets.to_i

      @item_repo.create(new_item) 

      @io.puts('Successfully created!')

    elsif option == '3'
      @io.puts("Here's a list of all orders:")
      @io.puts("\n")
      @order_repo.all.each do |order|
        items_list = ''
        order.items.each {|item| items_list += "#{item[0]} x #{item[1]} "} 
        @io.puts(" ##{order.id} #{order.customer_name} - #{order.placed_date} - items: #{items_list.strip}")
      end
    elsif option == '4'  
      new_order = Order.new
      @io.puts('What is the customer name?')
      new_order.customer_name = @io.gets.chomp  

      loop do
        @io.puts("What item do you want to add? (Enter 'N' to end)")
        add_item = @io.gets.chomp
        break if add_item == 'N'
        @io.puts('How many do you want?')
        add_item_count = @io.gets.to_i
        new_order.items << [add_item,add_item_count]
      end
      @order_repo.create(new_order)
      @io.puts('Successfully created!')
    end

  end
end

if __FILE__ == $0
  app = Application.new(
    'items_orders_2',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
