require 'application'


RSpec.describe Application do
  def reset_tables
    seed_sql = File.read('spec/seeds_tests.sql')
    user = ENV['PGUSER1'].to_s
    password = ENV['PGPASSWORD'].to_s
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test', user: user, password: password })

    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_tables
  end

  describe "#print_all_items" do
    it "prints all shop items" do      
      io = double :io
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      expect(io).to receive(:puts).with("#1 - Item 1 - Price: 1 - Stock quantiy: 5")
      expect(io).to receive(:puts).with("#2 - Item 2 - Price: 2 - Stock quantiy: 10")
      app.print_all_items
    end
  end

  describe "#create_new_item" do
    it "creates a new shop item" do      
      io = double :io
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      expect(io).to receive(:puts).with("Enter item name:")
      expect(io).to receive(:gets).and_return("Item 3")
      expect(io).to receive(:puts).with("Enter item price:")
      expect(io).to receive(:gets).and_return("3")
      expect(io).to receive(:puts).with("Enter item stock quantity:")
      expect(io).to receive(:gets).and_return("15")
      expect(io).to receive(:puts).with("Item created.")
      app.create_new_item
    end
  end

  describe "#print_all_orders" do
    it "prints all shop orders" do      
      io = double :io
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      expect(io).to receive(:puts).with("#1 - Customer: Wendy - Item: Item 1 - Order date: 2022-01-13")
      expect(io).to receive(:puts).with("#2 - Customer: Jovi - Item: Item 2 - Order date: 2022-02-13")
      expect(io).to receive(:puts).with("#3 - Customer: Bob - Item: Item 1 - Order date: 2022-03-13")
      expect(io).to receive(:puts).with("#4 - Customer: Dave - Item: Item 2 - Order date: 2022-04-13")
      app.print_all_orders
    end
  end

  describe "#create_new_order" do
    it "creates a new shop order" do      
      io = double :io
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      expect(io).to receive(:puts).with("Enter customer name:")
      expect(io).to receive(:gets).and_return("Chandler")
      expect(io).to receive(:puts).with("Enter item name:")
      expect(io).to receive(:gets).and_return("Item 1")
      expect(io).to receive(:puts).with("Enter order date:")
      expect(io).to receive(:gets).and_return("2022-05-13")
      expect(io).to receive(:puts).with("Order created.")
      app.create_new_order
    end
  end

  describe "#run" do
    context "when option 1 is chosen" do
      it "prints all shop items" do
        io = double :io
        item_repository = ItemRepository.new
        order_repository = OrderRepository.new
        app = Application.new('shop_manager_test', io, item_repository, order_repository)
        expect(io).to receive(:puts).with("Welcome to the Makers (August 2022 Cohort) shop manager!")
        expect(io).to receive(:puts).with("What would you like to do?")
        expect(io).to receive(:puts).with("1 - List all shop items")
        expect(io).to receive(:puts).with("2 - Create a new item")
        expect(io).to receive(:puts).with("3 - List all orders")
        expect(io).to receive(:puts).with("4 - Create a new order")
        expect(io).to receive(:puts).with("Enter your choice:")
        expect(io).to receive(:gets).and_return("1")
        expect(io).to receive(:puts).with("#1 - Item 1 - Price: 1 - Stock quantiy: 5")
        expect(io).to receive(:puts).with("#2 - Item 2 - Price: 2 - Stock quantiy: 10")
        app.run
      end
    end

    context "when option 2 is chosen" do
      it "takes user input and creates a new shop item" do
        io = double :io
        item_repository = ItemRepository.new
        order_repository = OrderRepository.new
        app = Application.new('shop_manager_test', io, item_repository, order_repository)
        expect(io).to receive(:puts).with("Welcome to the Makers (August 2022 Cohort) shop manager!")
        expect(io).to receive(:puts).with("What would you like to do?")
        expect(io).to receive(:puts).with("1 - List all shop items")
        expect(io).to receive(:puts).with("2 - Create a new item")
        expect(io).to receive(:puts).with("3 - List all orders")
        expect(io).to receive(:puts).with("4 - Create a new order")
        expect(io).to receive(:puts).with("Enter your choice:")
        expect(io).to receive(:gets).and_return("2")
        expect(io).to receive(:puts).with("Enter item name:")
        expect(io).to receive(:gets).and_return("Item 3")
        expect(io).to receive(:puts).with("Enter item price:")
        expect(io).to receive(:gets).and_return("3")
        expect(io).to receive(:puts).with("Enter item stock quantity:")
        expect(io).to receive(:gets).and_return("15")
        expect(io).to receive(:puts).with("Item created.")
        app.run
      end
    end

    context "when option 3 is chosen" do
      it "prints all orders" do
        io = double :io
        item_repository = ItemRepository.new
        order_repository = OrderRepository.new
        app = Application.new('shop_manager_test', io, item_repository, order_repository)
        expect(io).to receive(:puts).with("Welcome to the Makers (August 2022 Cohort) shop manager!")
        expect(io).to receive(:puts).with("What would you like to do?")
        expect(io).to receive(:puts).with("1 - List all shop items")
        expect(io).to receive(:puts).with("2 - Create a new item")
        expect(io).to receive(:puts).with("3 - List all orders")
        expect(io).to receive(:puts).with("4 - Create a new order")
        expect(io).to receive(:puts).with("Enter your choice:")
        expect(io).to receive(:gets).and_return("3")
        expect(io).to receive(:puts).with("#1 - Customer: Wendy - Item: Item 1 - Order date: 2022-01-13")
        expect(io).to receive(:puts).with("#2 - Customer: Jovi - Item: Item 2 - Order date: 2022-02-13")
        expect(io).to receive(:puts).with("#3 - Customer: Bob - Item: Item 1 - Order date: 2022-03-13")
        expect(io).to receive(:puts).with("#4 - Customer: Dave - Item: Item 2 - Order date: 2022-04-13")
        app.run
      end
    end

    context "when option 4 is chosen" do
      it "takes user input and creates a new order" do
        io = double :io
        item_repository = ItemRepository.new
        order_repository = OrderRepository.new
        app = Application.new('shop_manager_test', io, item_repository, order_repository)
        expect(io).to receive(:puts).with("Welcome to the Makers (August 2022 Cohort) shop manager!")
        expect(io).to receive(:puts).with("What would you like to do?")
        expect(io).to receive(:puts).with("1 - List all shop items")
        expect(io).to receive(:puts).with("2 - Create a new item")
        expect(io).to receive(:puts).with("3 - List all orders")
        expect(io).to receive(:puts).with("4 - Create a new order")
        expect(io).to receive(:puts).with("Enter your choice:")
        expect(io).to receive(:gets).and_return("4")
        expect(io).to receive(:puts).with("Enter customer name:")
        expect(io).to receive(:gets).and_return("Chandler")
        expect(io).to receive(:puts).with("Enter item name:")
        expect(io).to receive(:gets).and_return("Item 1")
        expect(io).to receive(:puts).with("Enter order date:")
        expect(io).to receive(:gets).and_return("2022-05-13")
        expect(io).to receive(:puts).with("Order created.")
        app.run
      end
    end
  end

end
