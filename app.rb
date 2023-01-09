require_relative 'lib/database_connection'
require_relative './lib/item_repository'
require_relative './lib/order_repository'

class Application
    def initialize(database_name, io, item_repository, order_repository)
        DatabaseConnection.connect(database_name)
        @io = io
        @item_repository = item_repository
        @order_repository = order_repository
    end

    def run
        @io.puts "Welcome to the shop management program!"
        @io.puts "What would you like to do?"
        @io.puts "1 = List all shop items"
        @io.puts "2 = Create a new item"
        @io.puts "3 = List all orders"
        @io.puts "4 = Create a new order"
        @io.puts "5 = Increase stock of item"
        @io.puts "6 = Delete an order"
        get_choice
    end


    private 

    def get_choice 
        input = @io.gets.chomp
        fail "Please ensure input is either one of 1, 2, 3, 4, 5 or 6" unless input.to_i == 1 || input.to_i == 2 || input.to_i == 3 || input.to_i == 4 ||  input.to_i == 5 || input.to_i == 6
        if input.to_i == 1
            return_items_list
        elsif input.to_i == 2
            create_item
        elsif input.to_i == 3
            return_orders_list
        elsif input.to_i == 4
            create_order      
        elsif input.to_i == 5
            increase_stock
        elsif input.to_i == 6
            delete_order
        end
    end

    def return_items_list
        @io.puts "Here is the list of all shop items:"
            @item_repository.all.each do |item|
                @io.puts "#{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
            end
    end

    def create_item
        @io.puts "What item would you like to add?"
            item_name = @io.gets.chomp.downcase
            @io.puts "What is the unit price of this item?"
            unit_price = @io.gets.chomp.to_i
            @io.puts "What are the stock levels for this item?"
            stock_levels = @io.gets.chomp.to_i
            item = Item.new
            item.name = item_name
            item.unit_price = unit_price
            item.quantity = stock_levels
            @item_repository.create(item)
    end

    def return_orders_list
        @io.puts "Here is the list of all orders:"
            @order_repository.all.each do |order|
                @io.puts "#{order.id} #{order.customer_name} - Order date: #{order.order_date} - Item ID: #{order.item_id}"
            end
    end

    def create_order
        @io.puts "Please enter your full name"
            customer_name = @io.gets.chomp
            @io.puts "Please enter the item ID for the item you would like to order"
            item_id = @io.gets.chomp
            @io.puts "Please enter the date you would like to make this order in MM/DD/YYYY format"
            order_date = @io.gets.chomp
            order = Order.new
            order.customer_name = customer_name
            order.order_date = order_date
            order.item_id = item_id
            @order_repository.create(order)
    end

    def increase_stock
        @io.puts "Please enter the item id for the item you would like to increase stock for?"
        item_id = @io.gets.chomp.to_i
        @item_repository.increase_stock(item_id)
    end

    def delete_order
        @io.puts "Please enter the order id for the order you would like to delete?"
        order_id = @io.gets.chomp.to_i
        @order_repository.delete(order_id)
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