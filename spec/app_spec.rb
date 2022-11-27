require 'app'
require 'item'
require 'order'
require 'item_repository'
require 'order_repository'
require 'database_connection'

describe Application do

  def reset_items_table
    seed_sql = File.read('spec/seeds_stock.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  def reset_orders_table
    seed_sql = File.read('spec/seeds_stock.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_items_table
    reset_orders_table
  end

  it "returns an accurate list of items" do

    io = double :io
    expect(io).to receive(:puts).with("Welcome to the shop manager!")
    expect(io).to receive(:puts).with("What would you like to do?")
    expect(io).to receive(:puts).with("1 - List all items")
    expect(io).to receive(:puts).with("2 - List all orders")
    expect(io).to receive(:puts).with("3 - Add an item")
    expect(io).to receive(:puts).with("4 - Add an order")

    expect(io).to receive(:puts).with("Enter Your Choice:")

    expect(io).to receive(:gets).and_return("1")

    expect(io).to receive(:puts).with("1 - Bag - £35.5 - 23")
    expect(io).to receive(:puts).with("2 - Lipstick - £15 - 49")
    expect(io).to receive(:puts).with("3 - Mascara - £18.4 - 4")

    app = Application.new('shop_manager_test', io, ItemRepository.new(io), OrderRepository.new(io))
    app.run

  end

  it "returns an accurate list of orders" do

    io = double :io
    expect(io).to receive(:puts).with("Welcome to the shop manager!")
    expect(io).to receive(:puts).with("What would you like to do?")
    expect(io).to receive(:puts).with("1 - List all items")
    expect(io).to receive(:puts).with("2 - List all orders")
    expect(io).to receive(:puts).with("3 - Add an item")
    expect(io).to receive(:puts).with("4 - Add an order")

    expect(io).to receive(:puts).with("Enter Your Choice:")

    expect(io).to receive(:gets).and_return("2")

    expect(io).to receive(:puts).with("1 - Lucas Smith - 2022-10-28 - 1")
    expect(io).to receive(:puts).with("2 - Abigail Brown - 2022-11-28 - 3")
    expect(io).to receive(:puts).with("3 - Sally Bright - 2022-11-16 - 1")

    app = Application.new('shop_manager_test', io, ItemRepository.new(io), OrderRepository.new(io))
    app.run

  end

  it "adds an item to the items table" do

    io = double :io
    expect(io).to receive(:puts).with("Welcome to the shop manager!")
    expect(io).to receive(:puts).with("What would you like to do?")
    expect(io).to receive(:puts).with("1 - List all items")
    expect(io).to receive(:puts).with("2 - List all orders")
    expect(io).to receive(:puts).with("3 - Add an item")
    expect(io).to receive(:puts).with("4 - Add an order")

    expect(io).to receive(:puts).with("Enter Your Choice:")

    expect(io).to receive(:gets).and_return("3")

    expect(io).to receive(:puts).with("ID:")
    expect(io).to receive(:gets).and_return('4')
    expect(io).to receive(:puts).with("item name:")
    expect(io).to receive(:gets).and_return('Nail File')
    expect(io).to receive(:puts).with("item unit price:")
    expect(io).to receive(:gets).and_return('1')
    expect(io).to receive(:puts).with("quantity of item:")
    expect(io).to receive(:gets).and_return('21')

    expect(io).to receive(:puts).with("1 - Bag - £35.5 - 23")
    expect(io).to receive(:puts).with("2 - Lipstick - £15 - 49")
    expect(io).to receive(:puts).with("3 - Mascara - £18.4 - 4")
    expect(io).to receive(:puts).with("4 - Nail File - £1 - 21")

    app = Application.new('shop_manager_test', io, ItemRepository.new(io), OrderRepository.new(io))
    app.run
    app.list_items

  end

  it "adds an order to the orders table" do

    io = double :io
    expect(io).to receive(:puts).with("Welcome to the shop manager!")
    expect(io).to receive(:puts).with("What would you like to do?")
    expect(io).to receive(:puts).with("1 - List all items")
    expect(io).to receive(:puts).with("2 - List all orders")
    expect(io).to receive(:puts).with("3 - Add an item")
    expect(io).to receive(:puts).with("4 - Add an order")

    expect(io).to receive(:puts).with("Enter Your Choice:")

    expect(io).to receive(:gets).and_return("4")

    expect(io).to receive(:puts).with("ID:")
    expect(io).to receive(:gets).and_return('4')
    expect(io).to receive(:puts).with("customer name:")
    expect(io).to receive(:gets).and_return('Jenny Boyle')
    expect(io).to receive(:puts).with("order date:")
    expect(io).to receive(:gets).and_return('2022-11-05')
    expect(io).to receive(:puts).with("ID of item ordered:")
    expect(io).to receive(:gets).and_return('2')

    expect(io).to receive(:puts).with("1 - Lucas Smith - 2022-10-28 - 1")
    expect(io).to receive(:puts).with("2 - Abigail Brown - 2022-11-28 - 3")
    expect(io).to receive(:puts).with("3 - Sally Bright - 2022-11-16 - 1")
    expect(io).to receive(:puts).with("4 - Jenny Boyle - 2022-11-05 - 2")

    app = Application.new('shop_manager_test', io, ItemRepository.new(io), OrderRepository.new(io))
    app.run
    app.list_orders

  end

  it "returns message 'Not a valid option.' when selection is not 1, 2, 3 or 4" do

    io = double :io
    expect(io).to receive(:puts).with("Welcome to the shop manager!")
    expect(io).to receive(:puts).with("What would you like to do?")
    expect(io).to receive(:puts).with("1 - List all items")
    expect(io).to receive(:puts).with("2 - List all orders")
    expect(io).to receive(:puts).with("3 - Add an item")
    expect(io).to receive(:puts).with("4 - Add an order")

    expect(io).to receive(:puts).with("Enter Your Choice:")

    expect(io).to receive(:gets).and_return("5")
    expect(io).to receive(:puts).with("Not a valid option.")

    app = Application.new('shop_manager_test', io, ItemRepository.new(io), OrderRepository.new(io))
    app.run

  end

end
