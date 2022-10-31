require_relative '../app'

RSpec.describe Application do
  def reset_items_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_items_table
  end

  it "returns all items with name price and quantity" do
    io = double :io
    order_repository = double :order_repository
    expect(io).to receive(:puts).with("Welcome to the Shop Manager!")
    expect(io).to receive(:puts).with("")
    expect(io).to receive(:puts).with("What would you like to do?")
    expect(io).to receive(:puts).with("1. List all shop items")
    expect(io).to receive(:puts).with("2. Create a new item")
    expect(io).to receive(:puts).with("3. List all orders")
    expect(io).to receive(:puts).with("4. Create a new order")
    expect(io).to receive(:puts).with("0. Exit")
    expect(io).to receive(:puts).with("Choose action: ")
    expect(io).to receive(:gets).and_return("1")

    expect(io).to receive(:puts).with("Here's a list of all shop items: ")
    expect(io).to receive(:puts).with("#1 Iphone 11 - Unit price: 1000 - Quantity: 10")
    expect(io).to receive(:puts).with("#2 Iphone 10 - Unit price: 900 - Quantity: 5")
    expect(io).to receive(:puts).with("#3 Iphone 8 - Unit price: 500 - Quantity: 1")

    app = Application.new('shop_test', io, ItemRepository.new, order_repository)
    app.run
  end

  it "creates an item record" do
    io = double :io
    order_repository = double :order_repository 

    expect(io).to receive(:puts).with("Welcome to the Shop Manager!")
    expect(io).to receive(:puts).with("")
    expect(io).to receive(:puts).with("What would you like to do?")
    expect(io).to receive(:puts).with("1. List all shop items")
    expect(io).to receive(:puts).with("2. Create a new item")
    expect(io).to receive(:puts).with("3. List all orders")
    expect(io).to receive(:puts).with("4. Create a new order")
    expect(io).to receive(:puts).with("0. Exit")
    expect(io).to receive(:puts).with("Choose action: ")

    expect(io).to receive(:gets).and_return("2")

    expect(io).to receive(:puts).with("Enter item name: ")
    expect(io).to receive(:gets).and_return("Sony Xperia")
    expect(io).to receive(:puts).with("Enter Item Price: ")
    expect(io).to receive(:gets).and_return("300")
    expect(io).to receive(:puts).with("Enter Quantity: ")
    expect(io).to receive(:gets).and_return("11")

    app = Application.new('shop_test', io, ItemRepository.new, order_repository)
    app.run
  end 

  it "returns all orders with customer name, date ordered and item" do
    io = double :io

    expect(io).to receive(:puts).with("Welcome to the Shop Manager!")
    expect(io).to receive(:puts).with("")
    expect(io).to receive(:puts).with("What would you like to do?")
    expect(io).to receive(:puts).with("1. List all shop items")
    expect(io).to receive(:puts).with("2. Create a new item")
    expect(io).to receive(:puts).with("3. List all orders")
    expect(io).to receive(:puts).with("4. Create a new order")
    expect(io).to receive(:puts).with("0. Exit")
    expect(io).to receive(:puts).with("Choose action: ")
    expect(io).to receive(:gets).and_return("3")

    expect(io).to receive(:puts).with("Here's a list of all shop orders: ")
    expect(io).to receive(:puts).with("#1 Mike - Ordered date: 2022-10-01 - Ordered item: Iphone 11")
    expect(io).to receive(:puts).with("#2 John - Ordered date: 2022-10-25 - Ordered item: Iphone 10")
    expect(io).to receive(:puts).with("#2 John - Ordered date: 2022-10-25 - Ordered item: Iphone 8")
    expect(io).to receive(:puts).with("#3 Sam - Ordered date: 2022-10-27 - Ordered item: Iphone 11")
    app = Application.new('shop_test', io, ItemRepository.new, OrderRepository.new)
    app.run
  end

  it "creates an order record" do
    io = double :io

    expect(io).to receive(:puts).with("Welcome to the Shop Manager!")
    expect(io).to receive(:puts).with("")
    expect(io).to receive(:puts).with("What would you like to do?")
    expect(io).to receive(:puts).with("1. List all shop items")
    expect(io).to receive(:puts).with("2. Create a new item")
    expect(io).to receive(:puts).with("3. List all orders")
    expect(io).to receive(:puts).with("4. Create a new order")
    expect(io).to receive(:puts).with("0. Exit")
    expect(io).to receive(:puts).with("Choose action: ")

    expect(io).to receive(:gets).and_return("4")

    expect(io).to receive(:puts).with("Enter customer name: ")
    expect(io).to receive(:gets).and_return("Petr")

    expect(io).to receive(:puts).with("Here's a list of all shop items: ")
    expect(io).to receive(:puts).with("#1 Iphone 11 - Unit price: 1000 - Quantity: 10")
    expect(io).to receive(:puts).with("#2 Iphone 10 - Unit price: 900 - Quantity: 5")
    expect(io).to receive(:puts).with("#3 Iphone 8 - Unit price: 500 - Quantity: 1")
    expect(io).to receive(:puts).with("#4 Sony Xperia - Unit price: 300 - Quantity: 11")

    expect(io).to receive(:puts).with("Choose item: ")
    expect(io).to receive(:gets).and_return("1")
    
    app = Application.new('shop_test', io, ItemRepository.new, OrderRepository.new)
    app.run
  end
end
