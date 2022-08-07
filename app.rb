require_relative "./lib/database_connection"
require_relative "./lib/orders_repository"
require_relative "./lib/items_repository"

class Application
  def initialize(database_name, io, orders_repository, items_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @orders_repository = orders_repository
    @items_repository = items_repository
    @order_options_select = false
  end 
  def run
    @io.print "Welcome to the shop management program!\n"
    while true
      @io.print "What do you want to do?\n1: list all shop items\n2: list all item options\n3: list all orders\n4: list all order options\n5: QUIT\n"
      anwser = @io.gets 
      case anwser
      when "1\n"
        print_all_items()

      when "2\n"
        run_items_options()
      when "3\n"
        print_all_orders()
      when "4\n"
        run_orders_options()
      when "5\n"
        exit
      end

    end   
  end 

  def run_orders_options
    @io.print "1: FIND by ID\n2: CREATE new order\n3: UPDATE order\n4: DELETE order\n"
    options_input = @io.gets
    case options_input
    when "1\n"
      @io.print "What order id would you like to search for? :"
      search_id = @io.gets
      repo = @orders_repository
      order = repo.find(search_id)
      @io.print "__________________________________________________\n"
      @io.print "| order ID | Customer NAME | Order date | Item ID |\n"
      @io.print "|     #{order.id}       #{order.customer_name}          #{order.order_date}     #{order.item_id}      |\n"
      @io.print "__________________________________________________\n"
    when "2\n"
      @io.print "what is the customer's name: "
      customer_name = @io.gets 
      @io.print "what is the Order date: "
      order_date = @io.gets
      @io.print "what the Item ID: "
      item_id = @io.gets
      repo = @orders_repository
      order = Order.new
      order.customer_name = customer_name 
      order.order_date = order_date
      order.item_id = item_id.to_i
      repo.create(order)
      print_all_orders()
    when "3\n"
      @io.print "what order id would you like to update"
      order_to_update = @io.gets 
      repo = @orders_repository
      order = repo.find(order_to_update)
      @io.print "what would you like to update?\n1: customer name\n2: order date\n3: item ID\n"
      update_option = @io.gets
      @io.print "what would you like to change it to? : "
      update_value = @io.gets
      if update_option == "1\n"
        order.customer_name = update_value
        repo.update(order)
      elsif update_option == "2\n"
        order.order_date = update_value
        repo.update(order)
      elsif update_option == "3\n"
        order.item_id = update_value.to_i
        repo.update(order)
      end
      print_all_orders()
    when "4\n"
      @io.print "what order id would you like to delete\n"
      order_to_delete = @io.gets
      repo = @orders_repository
      order = repo.find(order_to_delete)
      repo.delete(order)
      print_all_orders()
    end
  end 

  def run_items_options
    @io.print "1: FIND by ID\n2: CREATE new item\n3: UPDATE item\n4: DELETE item\n"
    options_input = @io.gets
    case options_input
    when "1\n"
      @io.print "What item id would you like to search for? :"
      search_id = @io.gets
      repo = @items_repository
      item = repo.find(search_id)
      @io.print "__________________________________________\n"
      @io.print "| item name   |     Price    | Quantity  |\n"
      @io.print "|   #{item.item_name}       #{item.price}          #{item.quantity}     |\n"
      @io.print "__________________________________________n"
    when "2\n"
      @io.print "what is the item's name: "
      item_name = @io.gets 
      @io.print "what is the item price: "
      price = @io.gets
      @io.print "what the Quantity: "
      quantity = @io.gets
      repo = @items_repository
      item = Item.new
      item.item_name = item_name 
      item.price = price.to_i
      item.quantity = quantity.to_i
      repo.create(item)
      print_all_items()
    when "3\n"
      @io.print "what item id would you like to update: "
      item_to_update = @io.gets 
      repo = @items_repository
      item = repo.find(item_to_update)
      @io.print "what would you like to update?\n1: item name\n2: price\n3: quantity\n"
      update_option = @io.gets
      @io.print "what would you like to change it to? : "
      update_value = @io.gets
      if update_option == "1\n"
        item.item_name = update_value
        repo.update(item)
      elsif update_option == "2\n"
        item.price = update_value.to_i
        repo.update(item)
      elsif update_option == "3\n"
        item.quantity = update_value.to_i
        repo.update(item)
      end
      print_all_items()
    when "4\n"
      @io.print "what item id would you like to delete\n"
      item_to_delete = @io.gets
      repo = @items_repository
      item = repo.find(item_to_delete)
      repo.delete(item)
      print_all_items()
    end
  end 
  
  def print_all_orders
    repo = @orders_repository.all
    @io.print "__________________________________________________\n"
    @io.print "| order ID | Customer NAME | Order date | Item ID |\n"
    repo.each{|order|
      @io.print "| #{order.id}          #{order.customer_name}           £#{order.order_date}   #{order.item_id}       |\n" 
    }
    @io.print "__________________________________________________\n"
  end

  def print_all_items 
    repo = @items_repository.all
    @io.print "_________________________________________\n"
    @io.print "| item ID | item NAME | Price | Quantity |\n"
    repo.each{|item|
      @io.print "| #{item.id}       | #{item.item_name}   £#{item.price}   #{item.quantity}      \n" 
    }
    @io.print "_________________________________________\n"
  end

end 

if __FILE__ == $0
  app = Application.new('shop_manager', Kernel, 
    OrdersRepository.new, 
    ItemsRepository.new)
  app.run
end