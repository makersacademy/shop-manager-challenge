require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    display_user_interface
    prompt_for_input
  end

  private

  def show(message)
    @io.puts(message)
  end

  def prompt(message)
    @io.puts(message)
    @io.gets.chomp
  end

  def display_user_interface
    show 'Welcome to the shop management program!'
    show 'What do you want to do?'
    show '1 - List all items'
    show '2 - Create a new item'
    show '3 - List all orders'
    show '4 - Create a new order'
  end

  def prompt_for_input
    input = prompt 'Enter your choice:'
    case input
    when '1'
      list_all_items
    when '2'
      create_new_item
    when '3'
      list_all_orders
    end
  end

  def list_all_items
    show 'Here is the list of items:'
    @item_repository.all.each do |item|
      show "#{item.id}. #{item.name} (#{item.price}) / In stock: #{item.quantity}"
    end
  end

  def create_new_item
    item = Item.new
    item.name = prompt "What item would you like to add?" 
    item.price = prompt "Please set the price in dollars." 
    item.quantity = prompt "Please set the quantity."
    @item_repository.create(item) 
    show "New item created: ID# #{@item_repository.all.last.id} - #{@item_repository.all.last.name} (#{@item_repository.all.last.price}) / In stock: #{@item_repository.all.last.quantity}"
  end

  def list_all_orders
    show 'Here is the list of orders:'
    @order_repository.all.each do |order|
      items = ''
      total = 0
      order_with_items = @order_repository.find_with_items(order.id)
      order_with_items.items.each do |item|
        items << "\n#{item.name} - #{item.price}"
        total += item.price[1..-1].to_f
      end
      show "\nOrder ID [#{order.id}] ordered by #{order.customer_name} on #{order.date}."
      show "Items ordered: #{items}"
      show "** Order total - $#{'%.2f' % total} **"
    end
  end

end

if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
