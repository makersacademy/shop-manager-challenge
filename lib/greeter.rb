require "stocks_repository"
require "orders_repository"


class Greeter
    def initialize(io)
      @io = io
    end
    def greet

      stocks_repo = StocksRepository.new
      all_stocks = stocks_repo.all 
      create_stocks = stocks_repo.create 

      orders_repo = OrdersRepository.new
      all_orders = orders_repo.all
      create_orders = orders_repo.create 

      @io.puts "Welcome to the shop management program!
  
      What do you want to do?
  
        1 = list all shop items
        2 = create a new item
        3 = list all orders
        4 = create a new order"
  
      name = @io.gets.chomp
      if name == 1
        @io.puts all_stocks
      elsif name == 2
        @io.puts create_stocks
      elsif name == 3
        @io.puts all_orders
      elsif name == 4
        @io.puts create_orders
      else @io.puts "Sorry, you have failed to read the question properly!"
      end
  
    end
  end