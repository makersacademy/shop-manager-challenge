require_relative "./lib/database_connection"
require_relative "./lib/orders_repository"
require_relative "./lib/items_repository"

class Application
  def initialize(database_name, io, orders_repository, items_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @orders_repository = orders_repository
    @items_repository = items_repository
  end 
  def run
    @io.print "Welcome to the shop management program!\n"
    @io.print "What do you want to do?\n1 = list all shop items\n2 = create a new item\n3 =list all orders\n4 = create a new order\n"
    anwser = @io.gets 
    case anwser
    when "1\n"
      repo = @items_repository.all
      @io.print "_________________________________________\n"
      @io.print "| item ID | item NAME | Price | Quantity |\n"
      repo.each{|item|
        @io.print "| #{item.id}       | #{item.item_name}   £#{item.price}   #{item.quantity}      \n" 
      }
      @io.print "_________________________________________\n" 
    when "3\n"
      repo = @orders_repository.all
      @io.print "__________________________________________________\n"
      @io.print "| order ID | Customer NAME | Order date | Item ID |\n"
      repo.each{|order|
        @io.print "| #{order.id}          #{order.customer_name}           £#{order.order_date}   #{order.item_id}       |\n" 
      }
      @io.print "__________________________________________________\n"
    end 
  end 

end 


if __FILE__ == $0
  app = Application.new('shop_manager', Kernel, 
    OrdersRepository.new, 
    ItemsRepository.new)
  app.run
end