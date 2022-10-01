require_relative "../app"

def reset_app_table
  seed_sql = File.read('spec/seeds_shop_manager.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do 
    reset_app_table
  end

  it "return a list of all shop items formatted" do
    io = double :io
    data_connection = double :database_connection
    item_repository = double :item_repository
    order_repository = double :order_repository
    item_1 = double :item_1, id: 1, name: 'Bananas', unit_price: '$1.00', quantity: 5, order_id: '1'
    item_2 = double :item_2, id: 2, name: 'Pasta', unit_price: '$2.00', quantity: 10, order_id: '2'
    item_3 = double :item_3, id: 3, name: 'Fish', unit_price: '$2.00', quantity: 8, order_id: '3'
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\nWhat do you want to do?\n 1 = List all shop items\n 2 = Create a new item\n 3 = List all orders\n 4 = Create a new order\n").ordered
    expect(io).to receive(:gets).and_return("1")
    expect(io).to receive(:puts).with("\nHere is the list of all shop items:").ordered
    expect(item_repository).to receive(:all).and_return [item_1, item_2, item_3]
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.run
  end
  it "return a list of all orders formatted" do
    io = double :io
    data_connection = double :database_connection
    item_repository = double :item_repository
    order_repository = double :order_repository
    order_1 = double :order_1, id: 1, customer_name: 'Aamir', date: '2022-08-05 12:00:00', item_id: 1
    order_2 = double :order_2, id: 2, customer_name: 'Khan', date: '2022-08-04 11:00:00', item_id: 2
    order_3 = double :order_3, id: 3, customer_name: 'Ak', date: '2022-08-03 15:00:00', item_id: 3
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\nWhat do you want to do?\n 1 = List all shop items\n 2 = Create a new item\n 3 = List all orders\n 4 = Create a new order\n").ordered
    expect(io).to receive(:gets).and_return("3")
    expect(io).to receive(:puts).with("\nHere is the list of all shop orders:").ordered
    expect(order_repository).to receive(:all).and_return [order_1, order_2, order_3]
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.run
  end

  it "fails if number is neither 1, 2, 3 or 4" do
    io = double :io
    data_connection = double :database_connection
    item_repository = double :item_repository
    order_repository = double :order_repository
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\nWhat do you want to do?\n 1 = List all shop items\n 2 = Create a new item\n 3 = List all orders\n 4 = Create a new order\n").ordered
    expect(io).to receive(:gets).and_return("5")
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    expect { app.run }.to raise_error "Please choose a valid option" 
  end

  it "creates a new shop item object and confirms it's been created" do
    io = double :io
    data_connection = double :database_connection
    order_repository = double :order_repository
    item_repository = double :item_repository, create: nil
    item = double :item
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\nWhat do you want to do?\n 1 = List all shop items\n 2 = Create a new item\n 3 = List all orders\n 4 = Create a new order\n").ordered
    expect(io).to receive(:gets).and_return("2")
    expect(io).to receive(:puts).with("Please give a name").ordered
    expect(io).to receive(:gets).and_return('Tomato')
    expect(io).to receive(:puts).with("Please give a unit price").ordered
    expect(io).to receive(:gets).and_return('0.2')
    expect(io).to receive(:puts).with("Please give a quantity").ordered
    expect(io).to receive(:gets).and_return('5')
    expect(io).to receive(:puts).with("Item created").ordered
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.run
  end


  it "creates a new shop order object and confirms it's been created" do
    io = double :io
    data_connection = double :database_connection
    order_repository = double :order_repository, create: nil
    item_repository = double :item_repository
    order = double :order
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\nWhat do you want to do?\n 1 = List all shop items\n 2 = Create a new item\n 3 = List all orders\n 4 = Create a new order\n").ordered
    expect(io).to receive(:gets).and_return("4")
    expect(io).to receive(:puts).with("Please give a customer name").ordered
    expect(io).to receive(:gets).and_return('Sian')
    expect(io).to receive(:puts).with("Please give a date in format YYYY-MM-DD HH:MM:SS").ordered
    expect(io).to receive(:gets).and_return('2022-08-08 00:00:00')
    expect(io).to receive(:puts).with("Please give an item id").ordered
    expect(io).to receive(:gets).and_return("2")
    expect(io).to receive(:puts).with("Order created").ordered
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.run
  end
end