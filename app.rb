require_relative "./lib/order_repository"
require_relative "./lib/item_repository"
require_relative "./lib/database_connection"

class Application
  def initialize(db_name, io, order_repo, item_repo)
    DatabaseConnection.connect(db_name)
    @io = io
    @order_repo = order_repo
    @item_repo = item_repo
    @options = ["list all shop items", "create a new item", "update an item's price",
                "update stock of an item", "list all orders", "create a new order"]
  end

  def run
    # runs the programme
    @io.puts "Welcome to the shop management program!"
    loop do
      print_options()
      choice()
      break unless continue?()
    end
  end

  private

  def print_options
    @io.puts ""
    @io.puts "What do you want to do?"
    @io.puts ""
    @options.each_with_index do |option, index|
      @io.puts "#{index + 1} = #{option}"
    end
    @io.puts ""
    @io.puts "Enter your option:"
  end

  def filter_input(input, pattern)
    return input.chars.select { |char| char[pattern] }.join
  end

  def choice
    choice = filter_input(@io.gets.chomp, /\d+/).to_i
    while choice <= 0 || choice == "" || choice > @options.length
      @io.puts "Invalid input. Please enter again:"
      choice = filter_input(@io.gets.chomp, /\d+/).to_i
    end
    case choice
    when 1
      valid_answer = true
      list_items()
    end
  end

  def continue?
    @io.puts ""
    @io.puts "Do you want to continue the programme? (y/n)"
    choice = filter_input(@io.gets.chomp, /y|n/)
    while choice == ""
      @io.puts "Invalid input. Please enter again:"
      choice = filter_input(@io.gets.chomp, /y|n/)
    end
    return choice == "y"
  end

  def list_items
    # prints out list of items on terminal
    # => Here's a list of all shop items:
    # =>  1. Super Shark Vacuum Cleaner - Unit price: 10 - Quantity: 30
    # =>  2. Makerspresso Coffee Machine - Unit price: 20 - Quantity: 15
    @io.puts 1
  end

  def list_orders
    # prints out list of orders on terminal
    # => Here's a list of all orders:
    # =>  1. 2023-02-03 Terry's Order:
    # =>    ----------
    # =>    Items:
    # =>      - Super Shark Vacuum Cleaner - Qty: 2
    # =>      - Makerspresso Coffee Machine - Qty: 5
    # =>    ----------
    # =>    Grand total: $120
    # =>    -------------------------------------------
    # =>  2. 2023-02-03 Terry's Order:
    # =>    ----------
    # =>    Items:
    # =>      - Super Shark Vacuum Cleaner - Qty: 2
    # =>    ----------
    # =>    Grand total: $20
    # =>    ----------
    @io.puts 5
  end

  def create_order
    # asks questions about the order:
    #   1. name
    #   loop:
    #     2. item id
    #     3. qty (can't be 0)
    #     4. check stock by calling 'is_enough_stock?'
    #     4. print out message & go back to 2 if there is no enough stock
    #     5. continue or done?
    #   end
    # calls 'create_order' from OrderRepository
    # print out 'Successfully created an order!'
    @io.puts 6
  end

  def create_item
    # asks for inputs:
    #   1. item name
    #   2. price
    #   3. quantity
    # calls 'create_item' from ItemRepository
    @io.puts 2
  end

  def update_price
    # asks for inputs:
    #   1. item id
    #   2. latest price
    # calls 'update_price' from ItemRepository
    @io.puts 3
  end

  def update_stock
    # asks for inputs:
    #   1. add / send out?
    #   1. item id
    #   2. quantity
    # calls 'update_stock' from ItemRepository
    @io.puts 4
  end
end

if __FILE__ == $0
  app = Application.new(
    "shop_manager",
    Kernel,
    OrderRepository.new,
    ItemRepository.new
  )
  app.run
end
