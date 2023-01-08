require_relative '../app'

RSpec.describe Application do
  def reset_items_table
    seed_sql = File.read('spec/items_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  def reset_order_table
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_items_table
    reset_order_table
  end

  context "when 1 is selected in the terminal" do
    it "#all will return all items" do
      io = double :io
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      expect(io).to receive(:puts).with("Welcome to your car showroom management program!")
      expect(io).to receive(:puts).with("What would you like to do?")
      expect(io).to receive(:puts).with("1 - List all items")
      expect(io).to receive(:puts).with("2 - Create a new item")
      expect(io).to receive(:puts).with("3 - List all orders")
      expect(io).to receive(:puts).with("4 - Create a new order")
      expect(io).to receive(:gets).and_return(1)
      expect(io).to receive(:puts).with("Here's a list of shop items:")
      expect(io).to receive(:puts).with("*1 Model: Mustang - Price: $47,630.00 - Quantity: 200")
      expect(io).to receive(:puts).with("*2 Model: Fiesta - Price: $19,060.00 - Quantity: 600")
      app.run
    end
  end

  context "when 2 is selected in the terminal" do
    it "#create will create a new item" do
      io = double :io
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      expect(io).to receive(:puts).with("Welcome to your car showroom management program!")
      expect(io).to receive(:puts).with("What would you like to do?")
      expect(io).to receive(:puts).with("1 - List all items")
      expect(io).to receive(:puts).with("2 - Create a new item")
      expect(io).to receive(:puts).with("3 - List all orders")
      expect(io).to receive(:puts).with("4 - Create a new order")
      expect(io).to receive(:gets).and_return(2)
      expect(io).to receive(:puts).with("Enter model")
      expect(io).to receive(:gets).and_return("Galaxy")
      expect(io).to receive(:puts).with("Enter price")
      expect(io).to receive(:gets).and_return(40400)
      expect(io).to receive(:puts).with("Enter quantity")
      expect(io).to receive(:gets).and_return(185)
      app.run
      all = item_repository.all
      expect(all.length).to eq 3
    end
  end

  context "when 3 is selected in the terminal" do
    it "#all will return all items" do
      io = double :io
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      expect(io).to receive(:puts).with("Welcome to your car showroom management program!")
      expect(io).to receive(:puts).with("What would you like to do?")
      expect(io).to receive(:puts).with("1 - List all items")
      expect(io).to receive(:puts).with("2 - Create a new item")
      expect(io).to receive(:puts).with("3 - List all orders")
      expect(io).to receive(:puts).with("4 - Create a new order")
      expect(io).to receive(:gets).and_return(3)
      expect(io).to receive(:puts).with("Here's a list of orders:")
      expect(io).to receive(:puts).with("* Name: M. Jones - Date: 2023-01-07 - Item ID: 1")
      expect(io).to receive(:puts).with("* Name: R. Davids - Date: 2023-01-08 - Item ID: 2")
      app.run
    end
  end

  context "when 4 is selected in the terminal" do
    it "#create will add an order and return all items" do
      io = double :io
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      expect(io).to receive(:puts).with("Welcome to your car showroom management program!")
      expect(io).to receive(:puts).with("What would you like to do?")
      expect(io).to receive(:puts).with("1 - List all items")
      expect(io).to receive(:puts).with("2 - Create a new item")
      expect(io).to receive(:puts).with("3 - List all orders")
      expect(io).to receive(:puts).with("4 - Create a new order")
      expect(io).to receive(:gets).and_return(4)
      expect(io).to receive(:puts).with("Enter name")
      expect(io).to receive(:gets).and_return("T. Money")
      expect(io).to receive(:puts).with("Enter date")
      expect(io).to receive(:gets).and_return('2023-01-04')
      expect(io).to receive(:puts).with("Enter item ID")
      expect(io).to receive(:gets).and_return(2)
      app.run
      all = order_repository.all
      expect(all.length).to eq 3 
      item_check = item_repository.find(2)
      expect(item_check.quantity).to eq 599
    end
  end

  context "when input other than 1-4 is entered into the terminal" do
    it "the program will loop back round" do
      io = double :io
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      expect(io).to receive(:puts).with("Welcome to your car showroom management program!")
      expect(io).to receive(:puts).with("What would you like to do?")
      expect(io).to receive(:puts).with("1 - List all items")
      expect(io).to receive(:puts).with("2 - Create a new item")
      expect(io).to receive(:puts).with("3 - List all orders")
      expect(io).to receive(:puts).with("4 - Create a new order")
      expect(io).to receive(:gets).and_return(6)
      expect(io).to receive(:puts).with("Welcome to your car showroom management program!")
      expect(io).to receive(:puts).with("What would you like to do?")
      expect(io).to receive(:puts).with("1 - List all items")
      expect(io).to receive(:puts).with("2 - Create a new item")
      expect(io).to receive(:puts).with("3 - List all orders")
      expect(io).to receive(:puts).with("4 - Create a new order")
      expect(io).to receive(:gets).and_return(3)
      expect(io).to receive(:puts).with("Here's a list of orders:")
      expect(io).to receive(:puts).with("* Name: M. Jones - Date: 2023-01-07 - Item ID: 1")
      expect(io).to receive(:puts).with("* Name: R. Davids - Date: 2023-01-08 - Item ID: 2")
      app.run
    end
  end
end