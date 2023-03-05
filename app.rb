require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'

DatabaseConnection.connect('shop')
puts 'Welcome to the shop management program!'

while true
  puts '
  What do you want to do?
    1 = list all shop items
    2 = create a new item
    3 = list all orders
    4 = create a new order
    5 = exit program
  '

  query = gets.chomp
  terminal_io = Kernel

  case query
    when "1"
      repo = ItemRepository.new(terminal_io)
      all_items = repo.list_all_items
      puts "Here's a list of all shop items:"
      all_items.each do |item|
        puts " #{item.id} - #{item.item_name} - "\
        "Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
      end

    when "2"
      repo = ItemRepository.new(terminal_io)
      repo.create_new_item

    when "3"
      repo = OrderRepository.new(terminal_io)
      all_orders = repo.list_all_orders
      puts "Here's a list of all shop orders:"
      all_orders.each do |order|
        puts " #{order.id} - #{order.customer_name} - "\
        "Order date: #{order.order_date} - Item id: #{order.item_id}"
      end

    when "4"
      repo = OrderRepository.new(terminal_io)
      repo.create_new_order

    when "5"
      break
    
    else
      puts "Incorrect input, try again!"
  end
end
