require 'database_connection'
require 'item_repository'
require 'order_repository'
require_relative '../app'

RSpec.describe Application do
  # snippet and function call copied and modified from repository class recipe
  def reset_tables
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_tables
  end

  describe "#list_all_items" do
    it "prints all items" do
      database_name = 'shop_manager_test'
      terminal = double(:terminal)
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new(database_name, terminal,
        item_repository, order_repository)
      menu_string = "Welcome to the shop management program!\n\n" \
        "What do you want to do?\n" \
        "  1 = list all shop items\n" \
        "  2 = create a new item\n" \
        "  3 = list all orders\n" \
        "  4 = create a new order"
      expect(terminal).to receive(:puts).with(menu_string).ordered
      expect(terminal).to receive(:gets).and_return('1').ordered
      choice_one_output = "\nHere's a list of all shop items:\n\n" \
        "#1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30\n" \
        "#2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15"
      expect(terminal).to receive(:puts).with(choice_one_output).ordered
      app.run
    end
  end

  describe "#create_item" do
    it "adds a new item" do
      database_name = 'shop_manager_test'
      terminal = double(:terminal)
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new(database_name, terminal,
        item_repository, order_repository)
      menu_string = "Welcome to the shop management program!\n\n" \
        "What do you want to do?\n" \
        "  1 = list all shop items\n" \
        "  2 = create a new item\n" \
        "  3 = list all orders\n" \
        "  4 = create a new order"
      expect(terminal).to receive(:puts).with(menu_string).ordered
      expect(terminal).to receive(:gets).and_return('2').ordered
      expect(terminal).to receive(:print).with("Enter item name: ").ordered
      expect(terminal).to receive(:gets).and_return("Super Cutlery Set").ordered
      expect(terminal).to receive(:print).with("Enter unit price: ").ordered
      expect(terminal).to receive(:gets).and_return("55").ordered
      expect(terminal).to receive(:print).with("Enter stock quantity: ").ordered
      expect(terminal).to receive(:gets).and_return("20").ordered
      expect(terminal).to receive(:puts).with("New item added.").ordered
      app.run
      latest_item = item_repository.all.last
      expect(latest_item.name).to eq "Super Cutlery Set"
      expect(latest_item.unit_price).to eq 55
      expect(latest_item.stock_quantity).to eq 20
    end
  end

  describe "#list_all_orders" do
    it "prints all orders with item name" do
      database_name = 'shop_manager_test'
      terminal = double(:terminal)
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new(database_name, terminal,
        item_repository, order_repository)
      menu_string = "Welcome to the shop management program!\n\n" \
        "What do you want to do?\n" \
        "  1 = list all shop items\n" \
        "  2 = create a new item\n" \
        "  3 = list all orders\n" \
        "  4 = create a new order"
      expect(terminal).to receive(:puts).with(menu_string).ordered
      expect(terminal).to receive(:gets).and_return('3').ordered
      choice_one_output = "\nHere's a list of all orders:\n\n" \
        "#1 John Doe - 2022-08-21 - Makerspresso Coffee Machine\n" \
        "#2 John Doe The Second - 2022-08-22 - Makerspresso Coffee Machine\n" \
        "#3 Jane Doe - 2022-08-23 - Makerspresso Coffee Machine\n" \
        "#4 Jane Doe - 2022-08-24 - Super Shark Vacuum Cleaner"
      expect(terminal).to receive(:puts).with(choice_one_output).ordered
      app.run
    end
  end

  describe "#create_order" do
    it "add a new order" do
      database_name = 'shop_manager_test'
      terminal = double(:terminal)
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new(database_name, terminal,
        item_repository, order_repository)
      menu_string = "Welcome to the shop management program!\n\n" \
        "What do you want to do?\n" \
        "  1 = list all shop items\n" \
        "  2 = create a new item\n" \
        "  3 = list all orders\n" \
        "  4 = create a new order"
      expect(terminal).to receive(:puts).with(menu_string).ordered
      expect(terminal).to receive(:gets).and_return('4').ordered
      item_list = "\nHere's a list of all shop items:\n\n" \
      "#1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30\n" \
      "#2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15"
      expect(terminal).to receive(:puts).with(item_list).ordered
      expect(terminal).to receive(:print).with("Pick an item by id: ").ordered
      expect(terminal).to receive(:gets).and_return("2").ordered
      expect(terminal).to receive(:print).with("Enter customer name: ").ordered
      expect(terminal).to receive(:gets).and_return("Johnny Doe").ordered
      expect(terminal).to receive(:print).with("Enter order date(yyyy-mm-dd): ").ordered
      expect(terminal).to receive(:gets).and_return("2022-08-30").ordered
      expect(terminal).to receive(:puts).with("New order added.").ordered
      app.run
      latest_order_entry = order_repository.all_with_item.last
      latest_order = latest_order_entry[0]
      expect(latest_order.id).to eq 5
      expect(latest_order.customer_name).to eq "Johnny Doe"
      expect(latest_order.order_date).to eq "2022-08-30"
      expect(latest_order.item_id).to eq 2
    end
  end
end
