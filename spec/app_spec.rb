require './app'

def reset_tables
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe Application do
  
  before(:each) do 
    reset_tables
  end

  it "asks the user for input and lists all items when asked" do
    io = double :io

    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("What do you want to do?
    1 = list all shop items
    2 = create a new item
    3 = list all orders
    4 = create a new order")
    expect(io).to receive(:gets).and_return("1")
    expect(io).to receive(:puts).with("Here's a list of all shop items:")
    expect(io).to receive(:puts).with("#1 Super Shark Vacuum Cleaner - Unit Price: 99 - Quantity: 30")
    expect(io).to receive(:puts).with("#2 Makerspresso Coffee Machine - Unit Price: 69 - Quantity: 15")
    expect(io).to receive(:puts).with("#3 Toastie Maker - Unit Price: 30 - Quantity: 60")

    app = Application.new(
      'shop_manager_test',
      io,
      ItemRepository.new,
      OrderRepository.new
    )
    app.run
  end 

  it "asks the user for input and lists all orders when asked" do
    io = double :io

    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("What do you want to do?
    1 = list all shop items
    2 = create a new item
    3 = list all orders
    4 = create a new order")
    expect(io).to receive(:gets).and_return("3")
    expect(io).to receive(:puts).with("Here's a list of all orders:")
    expect(io).to receive(:puts).with("#1 Name: Customer1 - Date: 2023-01-01 - Item ID: 1")
    expect(io).to receive(:puts).with("#2 Name: Customer2 - Date: 2023-01-10 - Item ID: 2")
    expect(io).to receive(:puts).with("#3 Name: Customer3 - Date: 2023-01-20 - Item ID: 3")
    
    app = Application.new(
      'shop_manager_test',
      io,
      ItemRepository.new,
      OrderRepository.new
    )
    app.run
  end

  it "asks the user for input and creates an item when asked" do
    io = double :io

    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("What do you want to do?
    1 = list all shop items
    2 = create a new item
    3 = list all orders
    4 = create a new order")
    expect(io).to receive(:gets).and_return("2")
    expect(io).to receive(:puts).with("What is the name of the item?")
    expect(io).to receive(:gets).and_return("Ice Cream Maker")
    expect(io).to receive(:puts).with("What is the price of the item?")
    expect(io).to receive(:gets).and_return("50")
    expect(io).to receive(:puts).with("What is the quantity of the item?")
    expect(io).to receive(:gets).and_return("20")
    expect(io).to receive(:puts).with("Item has been added")

    app = Application.new(
      'shop_manager_test',
      io,
      ItemRepository.new,
      OrderRepository.new
    )
    app.run
  end

  it "asks the user for input and creates an order when asked" do
    io = double :io

    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("What do you want to do?
    1 = list all shop items
    2 = create a new item
    3 = list all orders
    4 = create a new order")
    expect(io).to receive(:gets).and_return("4")
    expect(io).to receive(:puts).with("What is the name of the customer?")
    expect(io).to receive(:gets).and_return("Customer4")
    expect(io).to receive(:puts).with("What is the order date?")
    expect(io).to receive(:gets).and_return("2023-01-25")
    expect(io).to receive(:puts).with("What is the item ID?")
    expect(io).to receive(:gets).and_return("3")
    expect(io).to receive(:puts).with("Order has been added")

    app = Application.new(
      'shop_manager_test',
      io,
      ItemRepository.new,
      OrderRepository.new
    )
    app.run
  end

end
