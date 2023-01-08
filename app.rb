require_relative 'lib/database_connection'
require_relative 'lib/order_repository'
require_relative 'lib/stock_repository'

class Application 
    def initialize(database_name, io, stock_repository, order_repository)
        DatabaseConnection.connect(database_name)
        @io = io
        @stock_repository = stock_repository
        @order_repository = order_repository
    end

    def run
        @io.puts "Welcome to the shop management program!"
        @io.puts "What would you like to do?"
        @io.puts "1 - List all shop items"
        @io.puts "2 - create a new item"
        @io.puts "3 - list all orders"
        @io.puts "4 - create a new order"
        @io.puts "Enter your choice: "
        user_choice = @io.gets.chomp
    

        if user_choice == '1' 
            shop_list
        elsif user_choice == '2'
            add_item
        elsif user_choice == '3'
            order_list
        elsif user_choice == '4'
            create_order
        end
    end
    
  
    def shop_list
        @io.puts "Here is the list of all shop items:"
        stock_repository = StockRepository.new
        number = 1
        stock_repository.all.each do |record|
            @io.puts "##{number} - #{record.item_name} - Unit price: #{record.unit_price} - Quantity: #{record.quantity}"
            number += 1
        end
    end

    def add_item

    end

    def create_order

    end

    def order_list

    end


if __FILE__ == $0
    app = Application.new(
      'shop_manager_test',
      Kernel,
      StockRepository.new,
      OrderRepository.new
    )
    app.run
end

end