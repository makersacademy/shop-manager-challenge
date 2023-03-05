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
end