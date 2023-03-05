require_relative "../shop_manager"
require "order_repository"
require "item_repository"

describe Application do

  def reset_items_table
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_items_table
  end

  it "prints an interactive interface on the screen" do
    io = double :io
    expect(io).to receive(:puts).with("Welcome to the shop manager program!")
    expect(io).to receive(:puts).with("")
    expect(io).to receive(:puts).with("What would you like to do?")
    expect(io).to receive(:puts).with("1 - All the items")
    expect(io).to receive(:puts).with("2 - Create an item")
    expect(io).to receive(:puts).with("3 - All the orders")
    expect(io).to receive(:puts).with("4 - Create an order")
    
    shop_manager = Application.new("shop", io, ItemRepository.new, OrderRepository.new)
    shop_manager.interface
  end

  it "prints on the screen the list of all the items" do
    io = double :io
    expect(io).to receive(:puts).with("Here is a list of all the items in the shop.")
    expect(io).to receive(:puts).with("- ITEM 1: T-shirts, PRICE EACH: £30, QUANTITY: 25.")
    expect(io).to receive(:puts).with("- ITEM 2: Jumpers, PRICE EACH: £50, QUANTITY: 15.")
    expect(io).to receive(:puts).with("- ITEM 3: Trousers, PRICE EACH: £100, QUANTITY: 20.")
    expect(io).to receive(:puts).with("- ITEM 4: Shoes, PRICE EACH: £115, QUANTITY: 20.")

    shop_manager = Application.new("shop", io, ItemRepository.new, OrderRepository.new)
    shop_manager.choice_1
  end
  

  it "adds an item to the list of orders" do
    io = double :io
    expect(io).to receive(:puts).with("What's the name of the item you want to add?")
    expect(io).to receive(:gets).and_return("Jacket")
    expect(io).to receive(:puts).with("What's the unit price of the new item?")
    expect(io).to receive(:gets).and_return('150')
    expect(io).to receive(:puts).with("What's the quantity you have in store of that item?")
    expect(io).to receive(:gets).and_return('15')
    
    new_item = Item.new
    new_item.name = "Jacket"
    new_item.unit_price = 150
    new_item.quantity = 15

    shop_manager = Application.new("shop", io, ItemRepository.new, OrderRepository.new)
    shop_manager.choice_2

    repo = ItemRepository.new
    items = repo.all
    expect(items.length).to eq 5
    expect(items.last.name).to eq "Jacket"
    expect(items.last.unit_price).to eq "150"
    expect(items.last.quantity).to eq "15"
  end
  
  it "prints on the screen the list of all the orders" do
    io = double :io
    expect(io).to receive(:puts).with("Here is a list of all the order placed.")
    expect(io).to receive(:puts).with("ORDER 1 - CUSTOMER: David, DATE: 04-04-2022, ITEM_ID: 2.")
    expect(io).to receive(:puts).with("ORDER 2 - CUSTOMER: Anna, DATE: 10-05-2022, ITEM_ID: 1.")
    expect(io).to receive(:puts).with("ORDER 3 - CUSTOMER: John, DATE: 21-06-2022, ITEM_ID: 4.")
    expect(io).to receive(:puts).with("ORDER 4 - CUSTOMER: Jessica, DATE: 31-07-2022, ITEM_ID: 3.")

    shop_manager = Application.new("shop", io, ItemRepository.new, OrderRepository.new)
    shop_manager.choice_3
  end

  it "creates a new order and adds it to the database" do
    io = double :io
    expect(io).to receive(:puts).with("What's the customer's name for this purchase?")
    expect(io).to receive(:gets).and_return("Francesco")
    expect(io).to receive(:puts).with("What's the date the purchase was made?")
    expect(io).to receive(:gets).and_return("05-03-2023")
    expect(io).to receive(:puts).with("What's the ID of the item purchased?")
    expect(io).to receive(:gets).and_return('4')

    new_order = Order.new
    new_order.customer_name = "Francesco"
    new_order.date = "05-03-2023"
    new_order.item_id = 4

    shop_manager = Application.new("shop", io, ItemRepository.new, OrderRepository.new)
    shop_manager.choice_4
    
    repo = OrderRepository.new
    orders = repo.all
    expect(orders.length).to eq 5
    expect(orders.last.customer_name).to eq "Francesco"
    expect(orders.last.date).to eq "05-03-2023"
    expect(orders.last.item_id).to eq "4"
  end
end



