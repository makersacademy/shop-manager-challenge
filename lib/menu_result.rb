require 'item_repository'

class MenuResult
  def initialize(io)
    @io = io
  end

  def list_items
    @io.puts("Here's a list of all shop items:")
    item_repository = ItemRepository.new
    item_repository.all.each do |item|
      @io.puts "##{item.id}: #{item.name}, Unit price: #{item.price}, Quantity: #{item.quantity}"
    end
  end

  def list_orders
    @io.puts("Here's a list of all orders:")
    order_repository = OrderRepository.new
    order_repository.all.each do |order|
      @io.puts "##{order.id}: #{order.date}, Customer: #{order.customer_name}, Item id: #{order.item_id}"
    end
  end

  def create_item
    item = Item.new
    @io.puts("Insert name:")
    item.name = @io.gets.chomp
    @io.puts("Insert unit price:")
    item.price = @io.gets.chomp
    @io.puts("Insert quantity:")
    item.quantity = @io.gets.chomp
    item_repository = ItemRepository.new
    item_repository.create(item)
  end

  def create_order
    order = Order.new
    @io.puts("Insert date:")
    order.date = @io.gets.chomp
    @io.puts("Insert Customer name:")
    order.customer_name = @io.gets.chomp
    @io.puts("Insert Item id:")
    order.item_id = @io.gets.chomp
    order_repository = OrderRepository.new
    order_repository.create(order)
  end
    
  
end