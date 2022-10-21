require_relative '../app'

def reset_shop_database_tables
  seed_sql = File.read('spec/seeds_shop_data.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_database_test' })
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do 
    reset_shop_database_tables
  end

  it 'is an instance of Application class' do
    database_name = "shop_database_test"
    io = double :io
    item_repository = ItemRepository.new
    order_repository = OrderRepository.new
    app = Application.new(database_name, io, item_repository, order_repository)
    expect(item_repository).to be_instance_of(ItemRepository)
    expect(order_repository).to be_instance_of(OrderRepository)
    expect(app).to be_instance_of(Application)
  end

  context "asks for user input and receives option 1" do
    it "provides the list of all shop items in predefined format" do
      database_name = "shop_database_test"
      io = double :io
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n\n").ordered
      expect(io).to receive(:puts).with("What would you like to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n5 = view order details\n6 = view shop item balance").ordered
      expect(io).to receive(:gets).and_return("1").ordered
      expect(io).to receive(:puts).with("Here's the list of all shop items:").ordered
      expect(io).to receive(:puts).with("#1 milk - unit price: $1.00 - quantity: 35").ordered
      expect(io).to receive(:puts).with("#2 cheese - unit price: $3.50 - quantity: 55").ordered
      expect(io).to receive(:puts).with("#3 bread - unit price: $2.75 - quantity: 10").ordered
      expect(io).to receive(:puts).with("#4 6 eggs - unit price: $2.33 - quantity: 28").ordered
      expect(io).to receive(:puts).with("#5 orange juice - unit price: $1.30 - quantity: 20").ordered
      expect(io).to receive(:puts).with("Would you like to do anything else? (y/n)").ordered
      expect(io).to receive(:gets).and_return("n").ordered
      app = Application.new(database_name, io, item_repository, order_repository)
      app.run
    end
  end
  
  context "asks for user input and receives option 2" do
    it "creates an Item object and returns confirmation" do
      database_name = "shop_database_test"
      io = double :io
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n\n").ordered
      expect(io).to receive(:puts).with("What would you like to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n5 = view order details\n6 = view shop item balance").ordered
      expect(io).to receive(:gets).and_return("2").ordered
      expect(io).to receive(:puts).with("Please add item name, item price (1.00) and quantity available, separating them with commas:").ordered
      expect(io).to receive(:gets).and_return("orange,2.00,5").ordered
      expect(io).to receive(:puts).with("Item 'orange' has been added to the stocklist.").ordered
      expect(io).to receive(:puts).with("Would you like to do anything else? (y/n)").ordered
      expect(io).to receive(:gets).and_return("n").ordered 
      app = Application.new(database_name, io, item_repository, order_repository)
      app.run
    end
  end

  context "asks for user input and receives option 3" do
    it "provides the list of all orders in predefined format" do
      database_name = "shop_database_test"
      io = double :io
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n\n").ordered
      expect(io).to receive(:puts).with("What would you like to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n5 = view order details\n6 = view shop item balance").ordered
      expect(io).to receive(:gets).and_return("3").ordered
      expect(io).to receive(:puts).with("Here's the list of all orders:").ordered
      expect(io).to receive(:puts).with("Order #1 - Customer: Anna - Date: 2022-06-21").ordered
      expect(io).to receive(:puts).with("Order #2 - Customer: John - Date: 2022-06-23").ordered
      expect(io).to receive(:puts).with("Order #3 - Customer: Rachel - Date: 2022-07-01").ordered
      expect(io).to receive(:puts).with("Would you like to do anything else? (y/n)").ordered
      expect(io).to receive(:gets).and_return("n").ordered
      app = Application.new(database_name, io, item_repository, order_repository)
      app.run
    end
  end

  context "asks for user input and receives option 4" do
    it "creates an order with the list of bought items" do
      database_name = "shop_database_test"
      io = double :io
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n\n").ordered
      expect(io).to receive(:puts).with("What would you like to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n5 = view order details\n6 = view shop item balance").ordered
      expect(io).to receive(:gets).and_return("4").ordered
      expect(io).to receive(:puts).with("Please add client name and the date of the order (YYYY-MM-DD), separating them with a comma").ordered
      expect(io).to receive(:gets).and_return("Anna,2022-07-12").ordered
      expect(io).to receive(:puts).with("Please list the items you would like to add to your order, separating them with commas:").ordered
      expect(io).to receive(:puts).with("#1 milk - unit price: $1.00").ordered
      expect(io).to receive(:puts).with("#2 cheese - unit price: $3.50").ordered
      expect(io).to receive(:puts).with("#3 bread - unit price: $2.75").ordered
      expect(io).to receive(:puts).with("#4 6 eggs - unit price: $2.33").ordered
      expect(io).to receive(:puts).with("#5 orange juice - unit price: $1.30").ordered
      expect(io).to receive(:gets).and_return("1,2,3,4").ordered
      expect(io).to receive(:puts).with("Order #4 for Anna has been created on 2022-07-12").ordered
      expect(io).to receive(:puts).with("Would you like to do anything else? (y/n)").ordered
      expect(io).to receive(:gets).and_return("n").ordered
      app = Application.new(database_name, io, item_repository, order_repository)
      app.run
    end
  end
  
  context "asks for user input and receives option 5" do
    it "provides an order by its ID and associated items in predefined format" do
      database_name = "shop_database_test"
      io = double :io
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n\n").ordered
      expect(io).to receive(:puts).with("What would you like to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n5 = view order details\n6 = view shop item balance").ordered
      expect(io).to receive(:gets).and_return("5").ordered
      expect(io).to receive(:puts).with("What is the order ID number?").ordered
      expect(io).to receive(:gets).and_return("1").ordered
      expect(io).to receive(:puts).with("Order #1 - Customer: Anna - Date: 2022-06-21").ordered
      expect(io).to receive(:puts).with("Here's the list of items ordered:").ordered
      expect(io).to receive(:puts).with("#1 milk - unit price: $1.00 - quantity available: 35").ordered
      expect(io).to receive(:puts).with("#2 cheese - unit price: $3.50 - quantity available: 55").ordered
      expect(io).to receive(:puts).with("#5 orange juice - unit price: $1.30 - quantity available: 20").ordered
      expect(io).to receive(:puts).with("Would you like to do anything else? (y/n)").ordered
      expect(io).to receive(:gets).and_return("n").ordered
      app = Application.new(database_name, io, item_repository, order_repository)
      app.run
    end
  end

  context "asks for user input and receives option 6" do
    it "provides the details of the item by its ID, available stock, reserved stock and associated orders" do
      database_name = "shop_database_test"
      io = double :io
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n\n").ordered
      expect(io).to receive(:puts).with("What would you like to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n5 = view order details\n6 = view shop item balance").ordered
      expect(io).to receive(:gets).and_return("6").ordered
      expect(io).to receive(:puts).with("What is the item ID number?").ordered
      expect(io).to receive(:gets).and_return("1").ordered
      expect(io).to receive(:puts).with("#1 milk - unit price: $1.00 - quantity available: 35").ordered
      expect(io).to receive(:puts).with("This item was ordered by:").ordered
      expect(io).to receive(:puts).with("Anna = order #1 - date: 2022-06-21").ordered
      expect(io).to receive(:puts).with("John = order #2 - date: 2022-06-23").ordered
      expect(io).to receive(:puts).with("Rachel = order #3 - date: 2022-07-01").ordered
      expect(io).to receive(:puts).with("Would you like to do anything else? (y/n)").ordered
      expect(io).to receive(:gets).and_return("n").ordered
      app = Application.new(database_name, io, item_repository, order_repository)
      app.run
    end
  end
end
