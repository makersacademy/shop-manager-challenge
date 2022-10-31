#RUN THE SHOP PROGRAM FROM HERE
$LOAD_PATH << "lib"
require 'orders'
require 'stocks'

class Application

    def initialize (a,b,c,d)
        DatabaseConnection.connect(a)
        @io = b
        #c,d are instances of classes
    end

    def run
        @io.puts "Welcome to the shop management program!"\
        "\nWhat do you want to do?"\
          "\n   1 = list all shop items"\
          "\n   2 = create a new item"\
          "\n   3 = list all orders"\
          "\n   4 = create a new order"
        input1 = @io.gets.chomp.to_i
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



