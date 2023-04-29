require_relative 'item_repository.rb'
require_relative 'order_repository.rb'

class Application

  def initialize(database_name = 'shop_manager', io = Kernel, item_repository = ItemRepository.new, order_repository = OrderRepository.new)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.

    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
  end
end