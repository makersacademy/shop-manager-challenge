require_relative 'lib/database_connection'
require_relative 'lib/Order'
require_relative 'lib/Order_Repo'
require_relative 'lib/Item'
require_relative 'lib/Item_Repo'

class Application
  def initialize(shop_manager_test, io, item_repo, order_repo)
    DatabaseConnection.connect(shop_manager_test)
    @io = io
    @Orders_Repo = Orders_Repo
    @Items_Repo = Items_Repo
  end

  def run #we want to do like number connections 
    @io.puts "Welcome to shop management program!"
    @io.puts "What do you want to do?"
    @io.puts "1 = list all shop items"
    @io.puts "2 = create a new item"
    @io.puts "3 = list all orders"
    @io.puts "4 = create a new order"
    end
  end 

  def reply
    input = @io.gets.to_i
        if input == 1
            @io.puts "Here is the list of items"
            Item_Repo.all.each do |item| 
                @io.puts "#{item.id} - #{item.name} - #{item.price} - #{item.quantity}"
                    end
        else 
            fail "Please enter a valid number"
        end 
  end 

#

if __FILE__ == $0
  app = Application.new(
    'shop_manager_test',
    Kernel,
    Orders_Repo.new,
    Items_Repo.new
  )
  app.run
end