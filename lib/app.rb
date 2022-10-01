require_relative "../lib/item_repository"

class Application
  def initialize(io)
    @io = io
  end

  def run
    @io.puts "Welcome to the shop management program!"
    @io.puts ""
    @io.puts "What do you want to do?"
    @io.puts "  1 = list all shop items"
    @io.puts "  2 = create a new item"
    @io.puts "  3 = list all orders"
    @io.puts "  4 = create a new order"
    choice = @io.gets#.chomp
    
    # case choice
    # when 1
    #   puts "Here's a list of all shop items:"
    #   repo = ItemRepository.new
    #   items_list = repo.all_items
    # when 2

    # when 3

    # when 4

      

  #  1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30
  #  2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15
 
  end
end

