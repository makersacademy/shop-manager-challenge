require_relative '../app'
require 'item_repository'
require 'order_repository'

RSpec.describe Application do
  def reset_app_table
    seed_sql = File.read('spec/orders_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_app_table
  end

  it "print the header and symulate a wrong entry" do
    io = double :io
    order_repository = OrderRepository.new
    item_repository = ItemRepository.new
    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("")
    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with("1 = list all shop items")
    expect(io).to receive(:puts).with("2 = create a new item")
    expect(io).to receive(:puts).with("3 = list all orders")
    expect(io).to receive(:puts).with("4 = create a new order")
    expect(io).to receive(:gets).and_return("")
    expect(io).to receive(:puts).with("Please, select a number between 1 and 4")

    app = Application.new("shop_manager_test", io, order_repository, item_repository)
    app.run
  end

  it "returns the list of items" do
    io = double :io
    order_repository = OrderRepository.new
    item_repository = ItemRepository.new
    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("")
    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with("1 = list all shop items")
    expect(io).to receive(:puts).with("2 = create a new item")
    expect(io).to receive(:puts).with("3 = list all orders")
    expect(io).to receive(:puts).with("4 = create a new order")
    expect(io).to receive(:gets).and_return("1")
    expect(io).to receive(:puts).with("#1 Black Trousers - Unit price: 30 - Quantity: 52")
    expect(io).to receive(:puts).with("#2 Yellow T-shirt - Unit price: 20 - Quantity: 23")
    expect(io).to receive(:puts).with("#3 Nike Trainers - Unit price: 100 - Quantity: 12")

    app = Application.new("shop_manager_test", io, order_repository, item_repository)
    app.run
  end

  it "returns the list of orders" do
    io = double :io
    order_repository = OrderRepository.new
    item_repository = ItemRepository.new
    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("")
    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with("1 = list all shop items")
    expect(io).to receive(:puts).with("2 = create a new item")
    expect(io).to receive(:puts).with("3 = list all orders")
    expect(io).to receive(:puts).with("4 = create a new order")
    expect(io).to receive(:gets).and_return("3")
    expect(io).to receive(:puts).with("1 - Customer name: Marta Bianchini -  Date: 2023-09-01")
    expect(io).to receive(:puts).with("2 - Customer name: Name Surname -  Date: 2023-05-01")
    expect(io).to receive(:puts).with("3 - Customer name: Name_2 Surname_2 -  Date: 2023-03-01")
    expect(io).to receive(:puts).with("4 - Customer name: Name_3 Surname_3 -  Date: 2023-06-01")

    app = Application.new("shop_manager_test", io, order_repository, item_repository)
    app.run
  end

  it "adds a new item" do
    io = double :io
    order_repository = OrderRepository.new
    item_repository = ItemRepository.new
    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("")
    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with("1 = list all shop items")
    expect(io).to receive(:puts).with("2 = create a new item")
    expect(io).to receive(:puts).with("3 = list all orders")
    expect(io).to receive(:puts).with("4 = create a new order")
    expect(io).to receive(:gets).and_return("2")
    expect(io).to receive(:puts).with("insert the name of the item")
    expect(io).to receive(:gets).and_return("Blue Jeans")
    expect(io).to receive(:puts).with("insert the price of the item")
    expect(io).to receive(:gets).and_return("80")
    expect(io).to receive(:puts).with("insert the quantity of the item")
    expect(io).to receive(:gets).and_return("23")

    new_item = Item.new
    new_item.name = 'Blue Jeans'
    new_item.unit_price = 80
    new_item.quantity = 23
    item_repository.create(new_item)

    items = item_repository.all

    expect(items.length).to eq 4
    expect(items.last.name).to eq "Blue Jeans"

    app = Application.new("shop_manager_test", io, order_repository, item_repository)
    app.run
  end

  it "adds a new order" do
    io = double :io
    order_repository = OrderRepository.new
    item_repository = ItemRepository.new
    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("")
    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with("1 = list all shop items")
    expect(io).to receive(:puts).with("2 = create a new item")
    expect(io).to receive(:puts).with("3 = list all orders")
    expect(io).to receive(:puts).with("4 = create a new order")
    expect(io).to receive(:gets).and_return("4")
    expect(io).to receive(:puts).with("insert the name of the customer")
    expect(io).to receive(:gets).and_return("Mark Brown")
    expect(io).to receive(:puts).with("insert the date of the order (dd/mm/yyyy)")
    expect(io).to receive(:gets).and_return('09/01/2023')
    expect(io).to receive(:puts).with("insert the item id")
    expect(io).to receive(:gets).and_return('1')

    new_order = Order.new
    new_order.customer_name = 'Mark Brown'
    new_order.date = '09/01/2023'
    new_order.item_id = '1'

    order_repository.create(new_order)

    orders = order_repository.all

    expect(orders.length).to eq 5
    expect(orders.last.customer_name).to eq "Mark Brown"
    expect(orders.last.date).to eq "2023-09-01"
    expect(orders.last.item_id).to eq "1"

    app = Application.new("shop_manager_test", io, order_repository, item_repository)
    app.run
  end
end
