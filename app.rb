require_relative './lib/item'
require_relative './lib/order'

require_relative './lib/item_repository'
require_relative './lib/order_repository'
require_relative './lib/database_connection'
require 'date'

class Application
  attr_accessor :new_item, :new_order, :time
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    welcome_strings
    case @io.gets.to_i
    when 1 then list_all_shop_items
    when 2 then create_a_new_item
    when 3 then list_all_orders
    when 4 then create_a_new_order
    else fail "Choice must be an integer between 1 and 4"
    end
  end
  
  private

  def welcome_strings
    @io.puts "Welcome to the shop management program!"
    @io.puts "\nWhat would you like to do?"
    @io.puts "  1 = list all shop items"
    @io.puts "  2 = create a new item"
    @io.puts "  3 = list all orders"
    @io.puts "  4 = create a new order"
  end

  def list_all_shop_items
    @io.puts "\nHere's a list of all shop items:"
    @item_repository.all.each do |item|
      @io.puts "##{item.id} - #{item.name} - £#{item.unit_price} - #{item.quantity} in stock"
    end
  end

  def create_a_new_item
    ask_for_new_item_info
    @item_repository.create(new_item)
    @io.puts "\nItem created!"
  end

  def ask_for_new_item_info
    @io.puts "What is the item name?"
    new_item.name = @io.gets.chomp
    @io.puts "\nWhat is the unit_price? Enter the price to two decimal places, eg. 40.00"
    unit_price_check
    @io.puts "\nWhat is the quantity? Enter as a positive integer, eg. 500"
    quantity_check
  end

  def unit_price_check
    unit_price = @io.gets.chomp
    unit_price_fail = "Price must be a decimal number with two decimal places."
    fail unit_price_fail unless validate_unit_price(unit_price.split("."))
    new_item.unit_price = unit_price
  end

  def validate_unit_price(arr)
    return false unless arr.size == 2 && arr[0].to_i.to_s == arr[0] && arr[1].size == 2 &&
      arr[1].chars.all? { |char| "0123456789".include? char } rescue false
    true
  end

  def quantity_check
    quantity = @io.gets.chomp
    fail "Quantity must be a positive integer" unless
      quantity.to_i.positive? && quantity.to_i.to_s == quantity
    new_item.quantity = quantity
  end

  def list_all_orders
    @io.puts "\nHere's a list of all orders:"
    @order_repository.all.each do |order|
      @io.puts "##{order.id} - #{order.customer_name} -"
      @io.puts "#{order.date_ordered} - Item ID ##{order.item_id}"
    end
  end

  def create_a_new_order
    ask_for_new_order_info
    @order_repository.create(new_order)
    @io.puts "\nOrder created!"
  end

  def ask_for_new_order_info
    @io.puts "What is the customer name?"
    new_order.customer_name = @io.gets.chomp
    @io.puts "\nWhat is the order date? Enter as YYYY-MM-DD"
    date_ordered_check
    @io.puts "\nWhat is the ID of the ordered item?"
    item_id_check
  end

  def date_ordered_check
    date_ordered = @io.gets.chomp
    fail "Enter the date in the format YYYY-MM-DD" unless validate_date_ordered(date_ordered)
    new_order.date_ordered = date_ordered
  end

  def validate_date_ordered(string)
    time.to_date - Date.strptime(string, '%Y-%m-%d') >= 0 rescue false
    string.match(/\d{4}-\d{2}-\d{2}/)
  end

  def item_id_check
    item_id = @io.gets.chomp
    results = @item_repository.all
    fail "Item ID must exist in records" unless results.map(&:id).include? item_id
    fail "Item must be in stock" unless
      results.select { |record| record.id == item_id }[0].quantity.to_i.positive?
    new_order.item_id = item_id
  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  # p "works"
  app = Application.new(
    'shop_manager_test',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.time = Time.now
  app.new_order = Order.new
  app.new_item = Item.new
  app.run
end
