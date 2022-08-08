require_relative '../app'

def reset_table
  seed_sql = File.read('spec/seeds_shop_manager.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do 
    reset_table
  end

  it "lists all items" do
    io = double :io
    item_repository = double :item_repository
    order_repository = double :order_repository
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\nWhat would you like to do?").ordered
    expect(io).to receive(:puts).with("  1 = list all shop items").ordered
    expect(io).to receive(:puts).with("  2 = create a new item").ordered
    expect(io).to receive(:puts).with("  3 = list all orders").ordered
    expect(io).to receive(:puts).with("  4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("1")
    expect(io).to receive(:puts).with("\nHere's a list of all shop items:").ordered
    item1 = double :item, id: "1", name: "Climbing rope", unit_price: "40.99", quantity: "5"
    item2 = double :item, id: "2", name: "Waterproof jacket", unit_price: "50.00", quantity: "2"
    expect(item_repository).to receive(:all).and_return([item1, item2])
    expect(io).to receive(:puts).with("#1 - Climbing rope - £40.99 - 5 in stock").ordered
    expect(io).to receive(:puts).with("#2 - Waterproof jacket - £50.00 - 2 in stock").ordered
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.run
  end

  it "creates a new item" do
    io = double :io
    new_item = double :new_item
    item_repository = double :item_repository
    order_repository = double :order_repository
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\nWhat would you like to do?").ordered
    expect(io).to receive(:puts).with("  1 = list all shop items").ordered
    expect(io).to receive(:puts).with("  2 = create a new item").ordered
    expect(io).to receive(:puts).with("  3 = list all orders").ordered
    expect(io).to receive(:puts).with("  4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("2")
    expect(io).to receive(:puts).with("What is the item name?").ordered
    expect(io).to receive(:gets).and_return("Umbrella")
    expect(new_item).to receive(:name=).with("Umbrella")
    expect(io).to receive(:puts).with("\nWhat is the unit_price? Enter the price to two decimal places, eg. 40.00").ordered
    expect(io).to receive(:gets).and_return("30.00")
    expect(new_item).to receive(:unit_price=).with("30.00")
    expect(io).to receive(:puts).with("\nWhat is the quantity? Enter as a positive integer, eg. 500").ordered
    expect(io).to receive(:gets).and_return("45")
    expect(new_item).to receive(:quantity=).with("45")
    expect(item_repository).to receive(:create).with(new_item)
    expect(io).to receive(:puts).with("\nItem created!").ordered
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.new_item = new_item
    app.run
  end
  
  it "lists all orders" do
    io = double :io
    item_repository = double :item_repository
    order_repository = double :order_repository
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\nWhat would you like to do?").ordered
    expect(io).to receive(:puts).with("  1 = list all shop items").ordered
    expect(io).to receive(:puts).with("  2 = create a new item").ordered
    expect(io).to receive(:puts).with("  3 = list all orders").ordered
    expect(io).to receive(:puts).with("  4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("3")
    expect(io).to receive(:puts).with("\nHere's a list of all orders:").ordered
    order1 = double :order, id: "1", customer_name: "David Green", date_ordered: "2022-08-05", item_id: "3"
    order2 = double :order, id: "2", customer_name: "Nadine Dorris", date_ordered: "2022-07-30", item_id: "4"
    expect(order_repository).to receive(:all).and_return([order1, order2])
    expect(io).to receive(:puts).with("#1 - David Green -").ordered
    expect(io).to receive(:puts).with("2022-08-05 - Item ID #3").ordered
    expect(io).to receive(:puts).with("#2 - Nadine Dorris -").ordered
    expect(io).to receive(:puts).with("2022-07-30 - Item ID #4").ordered
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.run
  end

  it "creates a new order" do
    io = double :io
    new_order = double :new_order
    item_repository = double :item_repository
    order_repository = double :order_repository
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\nWhat would you like to do?").ordered
    expect(io).to receive(:puts).with("  1 = list all shop items").ordered
    expect(io).to receive(:puts).with("  2 = create a new item").ordered
    expect(io).to receive(:puts).with("  3 = list all orders").ordered
    expect(io).to receive(:puts).with("  4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("4")
    expect(io).to receive(:puts).with("What is the customer name?").ordered
    expect(io).to receive(:gets).and_return("Paddy Pimblett")
    expect(new_order).to receive(:customer_name=).with("Paddy Pimblett")
    expect(io).to receive(:puts).with("\nWhat is the order date? Enter as YYYY-MM-DD").ordered
    expect(io).to receive(:gets).and_return("2022-08-07")
    expect(new_order).to receive(:date_ordered=).with("2022-08-07")
    expect(io).to receive(:puts).with("\nWhat is the ID of the ordered item?").ordered
    expect(io).to receive(:gets).and_return("2")
    item1 = double :item, id: "1", name: "Climbing rope", price: "40.99", quantity: "5"
    item2 = double :item, id: "2", name: "Waterproof jacket", price: "50.00", quantity: "2"
    expect(item_repository).to receive(:all).and_return([item1, item2])
    expect(new_order).to receive(:item_id=).with("2")
    expect(order_repository).to receive(:create).with(new_order)
    expect(io).to receive(:puts).with("\nOrder created!").ordered
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.new_order = new_order
    app.time = Time.new(2022, 8, 8)
    app.run
  end

  it "fails if not entering a number between 1-4 for the menu choice" do
    io = double :io
    item_repository = double :item_repository
    order_repository = double :order_repository
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\nWhat would you like to do?").ordered
    expect(io).to receive(:puts).with("  1 = list all shop items").ordered
    expect(io).to receive(:puts).with("  2 = create a new item").ordered
    expect(io).to receive(:puts).with("  3 = list all orders").ordered
    expect(io).to receive(:puts).with("  4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("one")
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    expect { app.run }.to raise_error "Choice must be an integer between 1 and 4"
  end

  it "fails if unit price is not a positive decimal with two decimal places" do
    io = double :io
    new_item = double :new_item
    item_repository = double :item_repository
    order_repository = double :order_repository
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\nWhat would you like to do?").ordered
    expect(io).to receive(:puts).with("  1 = list all shop items").ordered
    expect(io).to receive(:puts).with("  2 = create a new item").ordered
    expect(io).to receive(:puts).with("  3 = list all orders").ordered
    expect(io).to receive(:puts).with("  4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("2")
    expect(io).to receive(:puts).with("What is the item name?").ordered
    expect(io).to receive(:gets).and_return("Umbrella")
    expect(new_item).to receive(:name=).with("Umbrella")
    expect(io).to receive(:puts).with("\nWhat is the unit_price? Enter the price to two decimal places, eg. 40.00").ordered
    expect(io).to receive(:gets).and_return("fruit.0")
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.new_item = new_item
    expect { app.run }.to raise_error "Price must be a decimal number with two decimal places."
  end

  it "fails if unit price is not a positive decimal with two decimal places, test 2" do
    io = double :io
    new_item = double :new_item
    item_repository = double :item_repository
    order_repository = double :order_repository
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\nWhat would you like to do?").ordered
    expect(io).to receive(:puts).with("  1 = list all shop items").ordered
    expect(io).to receive(:puts).with("  2 = create a new item").ordered
    expect(io).to receive(:puts).with("  3 = list all orders").ordered
    expect(io).to receive(:puts).with("  4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("2")
    expect(io).to receive(:puts).with("What is the item name?").ordered
    expect(io).to receive(:gets).and_return("Umbrella")
    expect(new_item).to receive(:name=).with("Umbrella")
    expect(io).to receive(:puts).with("\nWhat is the unit_price? Enter the price to two decimal places, eg. 40.00").ordered
    expect(io).to receive(:gets).and_return("40")
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.new_item = new_item
    expect { app.run }.to raise_error "Price must be a decimal number with two decimal places."
  end

  it "fails if unit price is not a positive decimal with two decimal places, test 3" do
    io = double :io
    new_item = double :new_item
    item_repository = double :item_repository
    order_repository = double :order_repository
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\nWhat would you like to do?").ordered
    expect(io).to receive(:puts).with("  1 = list all shop items").ordered
    expect(io).to receive(:puts).with("  2 = create a new item").ordered
    expect(io).to receive(:puts).with("  3 = list all orders").ordered
    expect(io).to receive(:puts).with("  4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("2")
    expect(io).to receive(:puts).with("What is the item name?").ordered
    expect(io).to receive(:gets).and_return("Umbrella")
    expect(new_item).to receive(:name=).with("Umbrella")
    expect(io).to receive(:puts).with("\nWhat is the unit_price? Enter the price to two decimal places, eg. 40.00").ordered
    expect(io).to receive(:gets).and_return("40.000")
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.new_item = new_item
    expect { app.run }.to raise_error "Price must be a decimal number with two decimal places."
  end

  it "fails if quantity is not a positive integer" do
    io = double :io
    new_item = double :new_item
    item_repository = double :item_repository
    order_repository = double :order_repository
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\nWhat would you like to do?").ordered
    expect(io).to receive(:puts).with("  1 = list all shop items").ordered
    expect(io).to receive(:puts).with("  2 = create a new item").ordered
    expect(io).to receive(:puts).with("  3 = list all orders").ordered
    expect(io).to receive(:puts).with("  4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("2")
    expect(io).to receive(:puts).with("What is the item name?").ordered
    expect(io).to receive(:gets).and_return("Umbrella")
    expect(new_item).to receive(:name=).with("Umbrella")
    expect(io).to receive(:puts).with("\nWhat is the unit_price? Enter the price to two decimal places, eg. 40.00").ordered
    expect(io).to receive(:gets).and_return("30.00")
    expect(new_item).to receive(:unit_price=).with("30.00")
    expect(io).to receive(:puts).with("\nWhat is the quantity? Enter as a positive integer, eg. 500").ordered
    expect(io).to receive(:gets).and_return("fifty")
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.new_item = new_item
    expect { app.run }.to raise_error "Quantity must be a positive integer"
  end

  it "fails if quantity is not a positive integer, test 2 with decimal" do
    io = double :io
    new_item = double :new_item
    item_repository = double :item_repository
    order_repository = double :order_repository
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\nWhat would you like to do?").ordered
    expect(io).to receive(:puts).with("  1 = list all shop items").ordered
    expect(io).to receive(:puts).with("  2 = create a new item").ordered
    expect(io).to receive(:puts).with("  3 = list all orders").ordered
    expect(io).to receive(:puts).with("  4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("2")
    expect(io).to receive(:puts).with("What is the item name?").ordered
    expect(io).to receive(:gets).and_return("Umbrella")
    expect(new_item).to receive(:name=).with("Umbrella")
    expect(io).to receive(:puts).with("\nWhat is the unit_price? Enter the price to two decimal places, eg. 40.00").ordered
    expect(io).to receive(:gets).and_return("30.00")
    expect(new_item).to receive(:unit_price=).with("30.00")
    expect(io).to receive(:puts).with("\nWhat is the quantity? Enter as a positive integer, eg. 500").ordered
    expect(io).to receive(:gets).and_return("40.5")
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.new_item = new_item
    expect { app.run }.to raise_error "Quantity must be a positive integer"
  end

  it "fails if given not a date" do
    io = double :io
    new_order = double :new_order
    item_repository = double :item_repository
    order_repository = double :order_repository
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\nWhat would you like to do?").ordered
    expect(io).to receive(:puts).with("  1 = list all shop items").ordered
    expect(io).to receive(:puts).with("  2 = create a new item").ordered
    expect(io).to receive(:puts).with("  3 = list all orders").ordered
    expect(io).to receive(:puts).with("  4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("4")
    expect(io).to receive(:puts).with("What is the customer name?").ordered
    expect(io).to receive(:gets).and_return("Paddy Pimblett")
    expect(new_order).to receive(:customer_name=).with("Paddy Pimblett")
    expect(io).to receive(:puts).with("\nWhat is the order date? Enter as YYYY-MM-DD").ordered
    expect(io).to receive(:gets).and_return("tuesday")
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.new_order = new_order
    app.time = Time.new(2022, 8, 8)
    expect { app.run }.to raise_error "Enter the date in the format YYYY-MM-DD"
  end

  it "fails if given date in the wrong format" do
    io = double :io
    new_order = double :new_order
    item_repository = double :item_repository
    order_repository = double :order_repository
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\nWhat would you like to do?").ordered
    expect(io).to receive(:puts).with("  1 = list all shop items").ordered
    expect(io).to receive(:puts).with("  2 = create a new item").ordered
    expect(io).to receive(:puts).with("  3 = list all orders").ordered
    expect(io).to receive(:puts).with("  4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("4")
    expect(io).to receive(:puts).with("What is the customer name?").ordered
    expect(io).to receive(:gets).and_return("Paddy Pimblett")
    expect(new_order).to receive(:customer_name=).with("Paddy Pimblett")
    expect(io).to receive(:puts).with("\nWhat is the order date? Enter as YYYY-MM-DD").ordered
    expect(io).to receive(:gets).and_return("2022-02")
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.new_order = new_order
    app.time = Time.new(2022, 8, 8)
    expect { app.run }.to raise_error "Enter the date in the format YYYY-MM-DD"
  end

  it "fails if given date in the wrong format, test2" do
    io = double :io
    new_order = double :new_order
    item_repository = double :item_repository
    order_repository = double :order_repository
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\nWhat would you like to do?").ordered
    expect(io).to receive(:puts).with("  1 = list all shop items").ordered
    expect(io).to receive(:puts).with("  2 = create a new item").ordered
    expect(io).to receive(:puts).with("  3 = list all orders").ordered
    expect(io).to receive(:puts).with("  4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("4")
    expect(io).to receive(:puts).with("What is the customer name?").ordered
    expect(io).to receive(:gets).and_return("Paddy Pimblett")
    expect(new_order).to receive(:customer_name=).with("Paddy Pimblett")
    expect(io).to receive(:puts).with("\nWhat is the order date? Enter as YYYY-MM-DD").ordered
    expect(io).to receive(:gets).and_return("2022-0204-")
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.new_order = new_order
    app.time = Time.new(2022, 8, 8)
    expect { app.run }.to raise_error "Enter the date in the format YYYY-MM-DD"
  end

  it "fails if Item ID is not an ID that exists in the records" do
    io = double :io
    new_order = double :new_order
    item_repository = double :item_repository
    order_repository = double :order_repository
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\nWhat would you like to do?").ordered
    expect(io).to receive(:puts).with("  1 = list all shop items").ordered
    expect(io).to receive(:puts).with("  2 = create a new item").ordered
    expect(io).to receive(:puts).with("  3 = list all orders").ordered
    expect(io).to receive(:puts).with("  4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("4")
    expect(io).to receive(:puts).with("What is the customer name?").ordered
    expect(io).to receive(:gets).and_return("Paddy Pimblett")
    expect(new_order).to receive(:customer_name=).with("Paddy Pimblett")
    expect(io).to receive(:puts).with("\nWhat is the order date? Enter as YYYY-MM-DD").ordered
    expect(io).to receive(:gets).and_return("2022-08-07")
    expect(new_order).to receive(:date_ordered=).with("2022-08-07")
    expect(io).to receive(:puts).with("\nWhat is the ID of the ordered item?").ordered
    expect(io).to receive(:gets).and_return("5")
    item1 = double :item, id: "1", name: "Climbing rope", price: "40.99", quantity: "5"
    item2 = double :item, id: "2", name: "Waterproof jacket", price: "50.00", quantity: "2"
    expect(item_repository).to receive(:all).and_return([item1, item2])
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.new_order = new_order
    app.time = Time.new(2022, 8, 8)
    expect { app.run }.to raise_error "Item ID must exist in records"
  end

  it "fails if Item ID is not in stock" do
    io = double :io
    new_order = double :new_order
    item_repository = double :item_repository
    order_repository = double :order_repository
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\nWhat would you like to do?").ordered
    expect(io).to receive(:puts).with("  1 = list all shop items").ordered
    expect(io).to receive(:puts).with("  2 = create a new item").ordered
    expect(io).to receive(:puts).with("  3 = list all orders").ordered
    expect(io).to receive(:puts).with("  4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("4")
    expect(io).to receive(:puts).with("What is the customer name?").ordered
    expect(io).to receive(:gets).and_return("Paddy Pimblett")
    expect(new_order).to receive(:customer_name=).with("Paddy Pimblett")
    expect(io).to receive(:puts).with("\nWhat is the order date? Enter as YYYY-MM-DD").ordered
    expect(io).to receive(:gets).and_return("2022-08-07")
    expect(new_order).to receive(:date_ordered=).with("2022-08-07")
    expect(io).to receive(:puts).with("\nWhat is the ID of the ordered item?").ordered
    expect(io).to receive(:gets).and_return("1")
    item1 = double :item, id: "1", name: "Climbing rope", price: "40.99", quantity: "0"
    expect(item_repository).to receive(:all).and_return([item1])
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.new_order = new_order
    app.time = Time.new(2022, 8, 8)
    expect { app.run }.to raise_error "Item must be in stock"
  end
end
