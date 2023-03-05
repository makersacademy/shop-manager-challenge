require_relative 'orders'
require_relative 'orders_repository'
require_relative 'items'
require_relative 'items_repository'
require_relative 'database_connection'


class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    display_menu
    choose_option
  end

  def display_menu
    @io.puts "Welcome to the shop management program"
    @io.puts "What do you want to do?"
    @io.puts "1 = list all shop items"
    @io.puts "2 = create a new item"
    @io.puts "3 = list all shop orders"
    @io.puts "4 = create a new  order"
  end

  def choose_option
    option = @io.gets.chomp

    case option
      when "1"
          list_all_shop_items
      when "3"
          list_all_shop_orders
    end
  end

  def list_all_shop_items
    @item_repository.all.each do |item|
     @io.puts "#{item.id} - #{item.item_name} - #{item.price} - #{item.quantity}"
    end
  end

  def list_all_shop_orders
    @order_repository.all.each do |order|
      @io.puts "#{order.id} - #{order.customer_name} - #{order.order_date} - #{order.item_id}"
    end
  end
end