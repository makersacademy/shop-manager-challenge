require_relative '../app.rb'
require_relative '../lib/database_connection'

database_name = 'shop_manager_test'

describe Application do  
  def reset_all_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_all_table()
  end

  it "return items when user chooses 1" do
    io = double :io
    order_repo = OrderRepository.new
    items_repo = ItemRepository.new

    app = Application.new(database_name, io, order_repo, items_repo, "02/04/2023")

    expect_start_menu(io)

    expect(io).to receive(:gets).and_return("1")

    expect(io).to receive(:puts).with("Here's a list of all shop items:\n\n")

    expect(io).to receive(:puts).with("1 Ray-Ban Sunglasses - Unit price: 80.0 - Quantity: 100")
    expect(io).to receive(:puts).with("2 Tefal set pans - Unit price: 150.0 - Quantity: 9")
    expect(io).to receive(:puts).with("3 Super Shark Vacuum Cleane - Unit price: 99.0 - Quantity: 30")
    expect(io).to receive(:puts).with("4 Makerspresso Coffee Machine - Unit price: 69.0 - Quantity: 15")
    expect(io).to receive(:gets).and_return("5")

    app.run

  end

  it "should create new item when user chooses 2" do
    io = double :io
    items_repo = double :item_repo_fake
    new_item = instance_double(Item) #this double allows to mock a constructor

    app = Application.new(database_name, io, nil, items_repo, "02/04/2023")

    expect_start_menu(io)
    expect(io).to receive(:gets).and_return("2")
    expect(io).to receive(:puts).with("Type Item name:")
    expect(io).to receive(:gets).and_return("Mixer")
    expect(io).to receive(:puts).with("Type Unit price:")
    expect(io).to receive(:gets).and_return("20")
    expect(io).to receive(:puts).with("Type quantity:")
    expect(io).to receive(:gets).and_return("10")

    #example of expect using constructor.
    expect(Item).to receive(:new).with(nil, "Mixer", "20", "10").and_return(new_item)
    expect(items_repo).to receive(:create).with(new_item)

    expect(io).to receive(:puts).with("Item Mixer succesfully created.")

    expect(io).to receive(:gets).and_return("5")

    app.run

  end

  it "return list of orders when user chooses 3" do
    io = double :io
    order_repo = OrderRepository.new
    items_repo = ItemRepository.new

    app = Application.new(database_name, io, order_repo, items_repo, "02/04/2023")

    expect_start_menu(io)
    
    expect(io).to receive(:gets).and_return("3")

    expect(io).to receive(:puts).with("Here is the list of orders:")

    expect(io).to receive(:puts).with("Order: 1 Date Placed: 2020-05-30 - Customer name: John Brown 
Items: 
  1 Ray-Ban Sunglasses - Unit price: 80.0
  2 Tefal set pans - Unit price: 150.0

Order: 2 Date Placed: 2020-04-20 - Customer name: Anne Smith 
Items: 
  3 Super Shark Vacuum Cleane - Unit price: 99.0
  2 Tefal set pans - Unit price: 150.0

")
    expect(io).to receive(:gets).and_return("5")

    app.run

  end

  it "should return order created" do 
    io = double :io
    item = instance_double(Item) #this double allows to mock a constructor
    orders_repo = double :order_repo_fake
    new_order = instance_double(Order) #this double allows to mock a constructor
    items_repo = double :item_repo_fake

    app = Application.new(database_name, io, orders_repo, items_repo, "02/04/2023")

    expect_start_menu(io)
    expect(io).to receive(:gets).and_return("4")
    expect(io).to receive(:puts).with("Starting your order: Type your name:")
    expect(io).to receive(:gets).and_return("Carolina")

    # Covers when item is sold out or is invalid
    expect(io).to receive(:puts).with("Type the id of your item or 0 to complete your order:")
    expect(io).to receive(:gets).and_return("10")
    expect(items_repo).to receive(:has_stock).with(10).and_return(false)
    expect(io).to receive(:puts).with("This item is sold out")

    # Covers inserting new item into Order
    expect(io).to receive(:puts).with("Type the id of your item or 0 to complete your order:")
    expect(io).to receive(:gets).and_return("1")
    expect(items_repo).to receive(:has_stock).with(1).and_return(true)

    #example of expect using constructor.
    expect(Item).to receive(:new).with(1).and_return(item)
    expect(Order).to receive(:new).with(nil, "02/04/2023", "Carolina").and_return(new_order)
    allow(new_order).to receive(:items).and_return([])

    # Covers when order is complete
    expect(io).to receive(:puts).with("Type the id of your item or 0 to complete your order:")
    expect(io).to receive(:gets).and_return("0")
    expect(orders_repo).to receive(:create_with_items).with(new_order)

    expect(io).to receive(:puts).with("Carolina, your order was succesfully placed.")

    expect(io).to receive(:gets).and_return("5")

    app.run

  end

end

def expect_start_menu(io)
  expect(io).to receive(:puts).with("Welcome to the shop management program!")
  expect(io).to receive(:puts).with("What do you want to do?")
  expect(io).to receive(:puts).with("1 = list all shop items")
  expect(io).to receive(:puts).with("2 = create a new item")
  expect(io).to receive(:puts).with("3 = list all orders")
  expect(io).to receive(:puts).with("4 = create a new order")
  expect(io).to receive(:puts).with("5 = exit")
end