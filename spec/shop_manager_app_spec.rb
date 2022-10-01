require_relative '../shop_manager_app'

RSpec.describe Application do
  def reset_items_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'items_orders_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_items_table
  end

  it "returns all items with name, unit price and quantity" do
    io = double :io
    order_repository = double :order_repository

    expect(io).to receive(:puts).with("Welcome to the Shop Manager!","").ordered
    expect(io).to receive(:puts).with("What would you like to do?").ordered
    expect(io).to receive(:puts).with(" 1 - list all shop items").ordered
    expect(io).to receive(:puts).with(" 2 - create a new item").ordered
    expect(io).to receive(:puts).with(" 3 - list all orders").ordered
    expect(io).to receive(:puts).with(" 4 - create a new order","").ordered
    expect(io).to receive(:puts).with("Enter you choice: ").ordered
    expect(io).to receive(:gets).and_return("1").ordered

    expect(io).to receive(:puts).with("Here's a list of all shop items: ").ordered
    expect(io).to receive(:puts).with("#1 Tower Air Fryer - Unit price: 55 - Quantity: 10").ordered
    expect(io).to receive(:puts).with("#2 Howork Stand Mixer - Unit price: 54 - Quantity: 23").ordered

    app = Application.new('items_orders_test', io, ItemRepository.new, order_repository)
    app.run
  end

  it "creates an item record" do
    io = double :io
    order_repository = double :order_repository 

    expect(io).to receive(:puts).with("Welcome to the Shop Manager!","").ordered
    expect(io).to receive(:puts).with("What would you like to do?").ordered
    expect(io).to receive(:puts).with(" 1 - list all shop items").ordered
    expect(io).to receive(:puts).with(" 2 - create a new item").ordered
    expect(io).to receive(:puts).with(" 3 - list all orders").ordered
    expect(io).to receive(:puts).with(" 4 - create a new order","").ordered
    expect(io).to receive(:puts).with("Enter you choice: ").ordered

    expect(io).to receive(:gets).and_return("2").ordered

    expect(io).to receive(:puts).with("Enter item name: ").ordered
    expect(io).to receive(:gets).and_return("Nespresso Coffee Machine").ordered
    expect(io).to receive(:puts).with("Enter Unit Price: ").ordered
    expect(io).to receive(:gets).and_return("79").ordered
    expect(io).to receive(:puts).with("Enter Quantity: ").ordered
    expect(io).to receive(:gets).and_return("30").ordered
    expect(io).to receive(:puts).with("Item added successfully!").ordered

    expect(io).to receive(:puts).with("Here's a list of all shop items: ").ordered
    expect(io).to receive(:puts).with("#1 Tower Air Fryer - Unit price: 55 - Quantity: 10").ordered
    expect(io).to receive(:puts).with("#2 Howork Stand Mixer - Unit price: 54 - Quantity: 23").ordered
    expect(io).to receive(:puts).with("#3 Nespresso Coffee Machine - Unit price: 79 - Quantity: 30").ordered
    
    app = Application.new('items_orders_test', io, ItemRepository.new, order_repository)
    app.run
  end 

  it "returns all orders with customer name, date ordered and item" do
    io = double :io

    expect(io).to receive(:puts).with("Welcome to the Shop Manager!","").ordered
    expect(io).to receive(:puts).with("What would you like to do?").ordered
    expect(io).to receive(:puts).with(" 1 - list all shop items").ordered
    expect(io).to receive(:puts).with(" 2 - create a new item").ordered
    expect(io).to receive(:puts).with(" 3 - list all orders").ordered
    expect(io).to receive(:puts).with(" 4 - create a new order","").ordered
    expect(io).to receive(:puts).with("Enter you choice: ").ordered
    expect(io).to receive(:gets).and_return("3").ordered

    expect(io).to receive(:puts).with("Here's a list of all shop orders: ").ordered
    expect(io).to receive(:puts).with("#1 Tinky-Winky - Ordered date: 2022-09-28 - Ordered item: Tower Air Fryer").ordered
    expect(io).to receive(:puts).with("#1 Tinky-Winky - Ordered date: 2022-09-28 - Ordered item: Howork Stand Mixer").ordered
    expect(io).to receive(:puts).with("#2 Dipsy - Ordered date: 2022-09-27 - Ordered item: Howork Stand Mixer").ordered

    app = Application.new('items_orders_test', io, ItemRepository.new, OrderRepository.new)
    app.run
  end

  it "creates an order record" do
    io = double :io

    expect(io).to receive(:puts).with("Welcome to the Shop Manager!","").ordered
    expect(io).to receive(:puts).with("What would you like to do?").ordered
    expect(io).to receive(:puts).with(" 1 - list all shop items").ordered
    expect(io).to receive(:puts).with(" 2 - create a new item").ordered
    expect(io).to receive(:puts).with(" 3 - list all orders").ordered
    expect(io).to receive(:puts).with(" 4 - create a new order","").ordered
    expect(io).to receive(:puts).with("Enter you choice: ").ordered

    expect(io).to receive(:gets).and_return("4").ordered

    expect(io).to receive(:puts).with("Enter customer name: ")
    expect(io).to receive(:gets).and_return("Olaf")
    expect(io).to receive(:puts).with("Enter date customer ordered: ")
    expect(io).to receive(:gets).and_return("2022-10-01")
    expect(io).to receive(:puts).with("Enter id of item customer ordered: ")
    expect(io).to receive(:gets).and_return("1")
    expect(io).to receive(:puts).with("Enter id of customer: ")
    expect(io).to receive(:gets).and_return("3")
    expect(io).to receive(:puts).with("Item added successfully!")

    expect(io).to receive(:puts).with("Here's a list of all shop orders: ").ordered
    expect(io).to receive(:puts).with("#1 Tinky-Winky - Ordered date: 2022-09-28 - Ordered item: Tower Air Fryer").ordered
    expect(io).to receive(:puts).with("#1 Tinky-Winky - Ordered date: 2022-09-28 - Ordered item: Howork Stand Mixer").ordered
    expect(io).to receive(:puts).with("#2 Dipsy - Ordered date: 2022-09-27 - Ordered item: Howork Stand Mixer").ordered
    expect(io).to receive(:puts).with("#3 Olaf - Ordered date: 2022-10-01 - Ordered item: Tower Air Fryer").ordered
    
    app = Application.new('items_orders_test', io, ItemRepository.new, OrderRepository.new)
    app.run
  end
end 
