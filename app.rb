require_relative './lib/db_connection'
require_relative './lib/item'
require_relative './lib/order'

require 'date'

class Application

  def initialize(database_name)
    @connection = DatabaseConnection.connect(database_name)
  end

  def list_items
    sql = 'SELECT name, price, quantity FROM items'
    results = @connection.exec_params(sql, [])
    items = []
    results.each do |item|
      puts item["name"],item["price"], item["quantity"]
    end
    run
  end

  def list_orders
    sql = 'SELECT order_name, date FROM orders'
    results = @connection.exec_params(sql, [])
    orders = []
    results.each do |order|
      puts order["order_name"]
      puts order["date"]

    end
    run
  end

  def create_order(name, date)
    order = Order.new
    order.order_name = name
    order.date = date

    sql = 'INSERT INTO orders (order_name, date) 
    VALUES ($1, $2);'
    params = [order.order_name, order.date]
    @connection.exec_params(sql, params)
    run
  end

  def add_order
    puts "enter name"
    order_name = gets.chomp()
    create_order(order_name, Time.now.strftime("%d/%m/%Y %H:%M"))
  
  end

  def add_item
    puts "enter name"
    name = gets.chomp()
    puts "enter price"
    price = gets.chomp()
    puts "enter quantity"
    quantity = gets.chomp()
    create_item(name, price, quantity)
  end

  def fetch_menu    
    return [
      "Select a task",
     "1 = list items", 
     "2 = create item",
     "3 = list orders",
     "4 = create order",
     "5 = quit"
    ]
  end

  def run 
    menu = fetch_menu
    menu.each do |option|
      puts option
    end
    selected = gets.chomp()
    case selected
    when "1" then list_items
    when "2" then add_item    
    when "3" then list_orders
    when "4" then add_order
    when "5" then abort

    end
  end
end

app = Application.new(
  'shop_manager',
)
app.run
