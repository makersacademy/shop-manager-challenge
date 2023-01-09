require_relative '../lib/app.rb'
require_relative '../lib/item_repo.rb'
require_relative '../lib/order_repo.rb'


def reset_shop_table
  seed_sql = File.read('spec/shop_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do 
    reset_shop_table
  end

  it "user chooses option 1 to list all items" do
    io = double :io
    order_repo = OrdersRepository.new
    item_repo = ItemsRepository.new
    database_name = 'shop_manager_test'
    new_app = Application.new(database_name, io, order_repo, item_repo)

    allow(io).to receive(:puts).with("Welcome to the shop management program!")
    allow(io).to receive(:puts).with("What do you want to do?")
    allow(io).to receive(:puts).with("1 - List all shop items")
    allow(io).to receive(:puts).with("2 - Create a new item")
    allow(io).to receive(:puts).with("3 - List all orders")
    allow(io).to receive(:puts).with("4 - Create a new order")
    
    allow(io).to receive(:gets).and_return("1")

    allow(io).to receive(:puts).with(["Cheese - 100 - 5", "Milk - 50 - 3", "Ham - 500 - 2"])

    new_app.run
  end

  it "user chooses option 2 to add item" do
    io = double :io
    order_repo = OrdersRepository.new
    item_repo = ItemsRepository.new
    database_name = 'shop_manager_test'
    new_app = Application.new(database_name, io, order_repo, item_repo)

    allow(io).to receive(:puts).with("Welcome to the shop management program!")
    allow(io).to receive(:puts).with("What do you want to do?")
    allow(io).to receive(:puts).with("1 - List all shop items")
    allow(io).to receive(:puts).with("2 - Create a new item")
    allow(io).to receive(:puts).with("3 - List all orders")
    allow(io).to receive(:puts).with("4 - Create a new order")
    allow(io).to receive(:puts).with("What item do you want to add?")
    allow(io).to receive(:puts).with("How many do you want to add?")
    allow(io).to receive(:puts).with("What price do you want to add?")
    
    
    allow(io).to receive(:gets).and_return("2", "Book", "10", "25")
    
    results = new_app.run
    items = item_repo.all
    
    expect(items[-1].id).to eq "4"
    expect(items[-1].item_name).to eq "Book"
    expect(items[-1].quantity).to eq "10"
    expect(items[-1].unit_price).to eq "25"
  end

  it "user chooses option 3 to list all orders" do
    io = double :io
    order_repo = OrdersRepository.new
    item_repo = ItemsRepository.new
    database_name = 'shop_manager_test'
    new_app = Application.new(database_name, io, order_repo, item_repo)

    allow(io).to receive(:puts).with("Welcome to the shop management program!")
    allow(io).to receive(:puts).with("What do you want to do?")
    allow(io).to receive(:puts).with("1 - List all shop items")
    allow(io).to receive(:puts).with("2 - Create a new item")
    allow(io).to receive(:puts).with("3 - List all orders")
    allow(io).to receive(:puts).with("4 - Create a new order")
    
    allow(io).to receive(:gets).and_return("3")

    expect(io).to receive(:puts).with(["Dave - 2022-01-01 - 1", "Helen - 2022-09-30 - 2", "Sam - 2022-12-25 - 3"])

    new_app.run
  end

  it "user chooses option 4 to add an orders" do
    io = double :io
    order_repo = OrdersRepository.new
    item_repo = ItemsRepository.new
    database_name = 'shop_manager_test'
    new_app = Application.new(database_name, io, order_repo, item_repo)

    allow(io).to receive(:puts).with("Welcome to the shop management program!")
    allow(io).to receive(:puts).with("What do you want to do?")
    allow(io).to receive(:puts).with("1 - List all shop items")
    allow(io).to receive(:puts).with("2 - Create a new item")
    allow(io).to receive(:puts).with("3 - List all orders")
    allow(io).to receive(:puts).with("4 - Create a new order")
    allow(io).to receive(:puts).with("Name of order")
    allow(io).to receive(:puts).with("Date of order")
    allow(io).to receive(:puts).with("Item chosen")
    
    allow(io).to receive(:gets).and_return("4", "Adam", "1991-08-30" ,"3")

    allow(io).to receive(:puts).with("Adam - 1991-08-30 - 3")

    results = new_app.run
    orders = order_repo.all
    
    expect(orders[-1].customer_name).to eq "Adam"
    expect(orders[-1].date).to eq "1991-08-30"
    expect(orders[-1].item_choice).to eq "3"
  end
end