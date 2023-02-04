require_relative "./lib/order_repository"
require_relative "./lib/item_repository"
require_relative "./lib/database_connection"

class Application
  def initialize(db_name, io, order_repo, item_repo)
    DatabaseConnection.connect(db_name)
    @io = io
    @order_repo = order_repo
    @item_repo = item_repo
  end

  def run
    # runs the programme
    # Steps:
    # 1. Print out welcome message and options
    # 2. Ask for action
    # 3. Check the response:
    #     1 = list all shop items
    #     2 = create a new item
    #     3 = update an item's price
    #     4 = update stock of an item
    #     5 = list all orders
    #     6 = create a new order
    #     7 = quit
    # 4. execute action
    # 5. loop back to step 1
  end

  private

  def list_items
    # prints out list of items on terminal
    # => Here's a list of all shop items:
    # =>  1. Super Shark Vacuum Cleaner - Unit price: 10 - Quantity: 30
    # =>  2. Makerspresso Coffee Machine - Unit price: 20 - Quantity: 15
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
  end

  def create_item
    # asks for inputs:
    #   1. item name
    #   2. price
    #   3. quantity
    # calls 'create_item' from ItemRepository
  end

  def update_price
    # asks for inputs:
    #   1. item id
    #   2. latest price
    # calls 'update_price' from ItemRepository
  end

  def update_stock
    # asks for inputs:
    #   1. add / send out?
    #   1. item id
    #   2. quantity
    # calls 'update_stock' from ItemRepository
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
