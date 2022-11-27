require_relative '../app.rb'
require_relative '../lib/item_repository.rb'
require_relative '../lib/order_repository.rb'

RSpec.describe Application do

  def reset_all_tables
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_items_orders_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_all_tables
  end

  it "lists all items" do
    
    item_repository = ItemRepository.new
    order_repository = double :order_repository
    io = double :io
    app = Application.new('shop_items_orders_test', io, item_repository, order_repository)

    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("\n")
    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with(" 1 = list all shop items")
    expect(io).to receive(:puts).with(" 2 = list all items in an order")
    expect(io).to receive(:puts).with(" 3 = list all shop orders")
    expect(io).to receive(:puts).with(" 4 = list all orders containing an item")
    expect(io).to receive(:puts).with("\n")
    expect(io).to receive(:print).with("Enter your choice: ")
    expect(io).to receive(:gets).and_return("1")
    expect(io).to receive(:puts).with("\n")

    result = app.run

    expect(result.first).to eq "#1 Item 1 - Unit price: 12.0000 - Quantity: 5"

  end

  it "lists orders related to a specific item" do
    
    order_repository = OrderRepository.new
    item_repository = ItemRepository.new
    io = double :io
    app = Application.new('shop_items_orders_test', io, item_repository, order_repository)

    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("\n")
    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with(" 1 = list all shop items")
    expect(io).to receive(:puts).with(" 2 = list all items in an order")
    expect(io).to receive(:puts).with(" 3 = list all shop orders")
    expect(io).to receive(:puts).with(" 4 = list all orders containing an item")
    expect(io).to receive(:puts).with("\n")
    expect(io).to receive(:print).with("Enter your choice: ")
    expect(io).to receive(:gets).and_return("2")
    expect(io).to receive(:puts).with("\n")

    expect(io).to receive(:puts).with("Enter item number:")
    expect(io).to receive(:gets).and_return("1")

    result = app.run

    expect(result.first).to eq "#3 Customer 3 - Order date: 2022-11-08"

  end

  it "lists all orders" do

    item_repository = double :item_repository
    order_repository = OrderRepository.new
    io = double :io
    app = Application.new('shop_items_orders_test', io, item_repository, order_repository)

    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("\n")
    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with(" 1 = list all shop items")
    expect(io).to receive(:puts).with(" 2 = list all items in an order")
    expect(io).to receive(:puts).with(" 3 = list all shop orders")
    expect(io).to receive(:puts).with(" 4 = list all orders containing an item")
    expect(io).to receive(:puts).with("\n")
    expect(io).to receive(:print).with("Enter your choice: ")
    expect(io).to receive(:gets).and_return("3")
    expect(io).to receive(:puts).with("\n")

    result = app.run

    expect(result.first).to eq "#1 Customer 1 - Order date: 2022-11-07"

  end

  it "lists items related to a specific order" do
    
    order_repository = OrderRepository.new
    item_repository = ItemRepository.new
    io = double :io
    app = Application.new('shop_items_orders_test', io, item_repository, order_repository)

    expect(io).to receive(:puts).with("Welcome to the shop management program!")
    expect(io).to receive(:puts).with("\n")
    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with(" 1 = list all shop items")
    expect(io).to receive(:puts).with(" 2 = list all items in an order")
    expect(io).to receive(:puts).with(" 3 = list all shop orders")
    expect(io).to receive(:puts).with(" 4 = list all orders containing an item")
    expect(io).to receive(:puts).with("\n")
    expect(io).to receive(:print).with("Enter your choice: ")
    expect(io).to receive(:gets).and_return("4")
    expect(io).to receive(:puts).with("\n")

    expect(io).to receive(:puts).with("Enter order number:")
    expect(io).to receive(:gets).and_return("3")

    result = app.run

    expect(result.first).to eq "#1 Item 1 - Unit price: 12.0000 - Quantity: 5"

  end

end