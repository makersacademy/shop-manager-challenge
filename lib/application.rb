require_relative "./item_repository"
require_relative "./order_repository"
require_relative "./database_connection"

class Application
  def initialize(
    database = "shop_manager",
    io = Kernel,
    item_repository = ItemRepository.new,
    order_repository = OrderRepository.new
  )
    DatabaseConnection.connect(database)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    print_welcome_options
    choice = @io.gets.chomp
    if choice == "1"
      items = @item_repository.all
      @io.puts("Here's a list of all shop items:\n")
      items.each_with_index { |item, i| print_item(item, i + 1) }
    end

    if choice == "2"
    end
  end
  
  private
  
  def print_item(item, list_number)
    price = item.unit_price.to_i
    formatted_price = "£#{price / 100}.#{price % 100}"
    @io.puts "##{list_number} #{item.name} - Unit price: #{formatted_price} - Quantity: #{item.quantity}"
  end
  
  def print_welcome_options
    @io.puts("Welcome to the shop management program!\n")
    @io.puts("What do you want to do?")
    @io.puts("  1 = list all shop items")
    @io.puts("  2 = create a new item")
    @io.puts("  3 = list all orders")
    @io.puts("  4 = create a new order")
    @io.puts("")
  end
end
