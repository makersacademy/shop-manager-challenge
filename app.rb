#RUN THE SHOP PROGRAM FROM HERE
$LOAD_PATH << "lib"
require 'orders'
require 'stocks'

class Application

    def initialize (database,inputkernel,orders_repo,stocks_repo)
        DatabaseConnection.connect(database)
        @io = inputkernel
        @ordersrepo = orders_repo
        @stocksrepo = stocks_repo
        
    end

    def run
      input1 = ""
      while input1 != 7 do
        @io.puts "Welcome to the shop management program!"\
          "\nWhat do you want to do?"\
            "\n   1 = list all shop items"\
            "\n   2 = create a new item"\
            "\n   3 = list all orders"\
            "\n   4 = create a new order"\
            "\n   5 = find a customer's order"\
            "\n   6 = view customers of a product"\
            "\n   7 = exit program"
          input1 = @io.gets.chomp.to_i
          case input1
            when 1 then 
              p @stocksrepo.show_all_stock #some formatting needed here, try and get sql table output into terminal
            when 2 then 
              @io.puts "enter your addition in format item-price-qty"
              input2 = @io.gets.chomp.split('-')
              @stocksrepo.add_new_item(input2[0],input2[1],input2[2])
              puts "#{input2[0]} successfully added to catalogue"
            when 3 then
            when 4 then 
            when 5 then
            when 6 then
            when 7 then puts "Goodbye!!!!!"
          end
      end
    end

end

if __FILE__ == $0
    app = Application.new(
      'shop2',
      Kernel,
      OrdersRepo.new,
      StockItemsRepo.new
    )
    app.run
  end



