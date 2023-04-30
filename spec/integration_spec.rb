require 'application'
require 'item_repository'
require 'order_repository'

def reset_test_tables
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

def welcome_screen_expects(io_dbl)
  expect(io_dbl).to receive(:puts)
    .with('Welcome to the shop management program!').ordered
  expect(io_dbl).to receive(:puts)
    .with("\nWhat do you want to do?").ordered
  expect(io_dbl).to receive(:puts)
    .with('1 = list all shop items').ordered
  expect(io_dbl).to receive(:puts)
    .with('2 = create a new item').ordered
  expect(io_dbl).to receive(:puts)
    .with('3 = list all order').ordered
  expect(io_dbl).to receive(:puts)
    .with('4 = create a new order').ordered
  expect(io_dbl).to receive(:puts)
    .with('5 = assign an item to an order').ordered
  expect(io_dbl).to receive(:puts)
    .with('6 = exit').ordered
end

RSpec.describe 'shop manager integration' do
  before(:each) do 
    reset_test_tables
  end

  describe 'welcome screen' do
    it ' displays a menu of choices and prompts an input' do
      io_dbl = double :io
      app = Application.new('shop_manager_test', io_dbl)

      welcome_screen_expects(io_dbl)
      expect(io_dbl).to receive(:gets)
        .and_return('choice').ordered

      app.run
        # will need a loop break once loop is implemented
    end
  end

  describe 'interactive behaviour' do
    context "when a user inputs 1" do
      it 'lists all shop items' do
        io_dbl = double :io
        app = Application.new('shop_manager_test', io_dbl)

        welcome_screen_expects(io_dbl)
        expect(io_dbl).to receive(:gets)
          .and_return("1\n").ordered
        expect(io_dbl).to receive(:puts)
          .with("1 item_one - Unit price: 1 - Quantity: 1\n2 item_two - Unit price: 2 - Quantity: 2\n3 item_three - Unit price: 3 - Quantity: 3\n4 item_four - Unit price: 4 - Quantity: 4\n5 item_five - Unit price: 5 - Quantity: 5\n").ordered
        # will need a loop break once loop is implemented
        app.run
      end
    end  

    context "when a user inputs 2" do
      it 'creates a new item' do
        io_dbl = double :io
        app = Application.new('shop_manager_test', io_dbl)

        welcome_screen_expects(io_dbl)

        expect(io_dbl).to receive(:gets)
          .and_return("2\n").ordered
          
        expect(io_dbl).to receive(:print)
          .with("\nPlease type the item's name?: ").ordered
        expect(io_dbl).to receive(:gets)
          .and_return("item_six").ordered
        expect(io_dbl).to receive(:print)
          .with("\nPlease type the item's price?: ").ordered
        expect(io_dbl).to receive(:gets)
          .and_return("6\n").ordered
        expect(io_dbl).to receive(:print)
          .with("\nPlease type the item's quantity?: ").ordered
        expect(io_dbl).to receive(:gets)
          .and_return("6\n").ordered

        app.run
  
        repo = app.instance_variable_get(:@item_repository)
        items = repo.all 
        expect(items.length).to eq 6
        expect(items.last.name).to eq "item_six"
        # will need a loop break once loop is implemented

      end

      # re-prompts if price or quantity is not an integer? re-prompts with empty input?
    end  

    context "when a user inputs 3" do
      it 'lists all orders' do
        io_dbl = double :io
        app = Application.new('shop_manager_test', io_dbl)

        welcome_screen_expects(io_dbl)

        expect(io_dbl).to receive(:gets)
          .and_return("3\n").ordered
        expect(io_dbl).to receive(:puts)
          .with("1 - Customer name: Jeff  - Order date: 2023-10-16 Items: item_one, item_five \n2 - Customer name: John  - Order date: 2023-11-16 Items: \n3 - Customer name: Jerry  - Order date: 2023-12-16 Items: item_three, item_four \n4 - Customer name: George  - Order date: 2024-01-16 Items: item_two \n").ordered
        # will need a loop break once loop is implemented
        
        app.run
      end
    end

    context "when a user inputs 4" do
      it 'creates a new order' do
        io_dbl = double :io
        app = Application.new('shop_manager_test', io_dbl)

        welcome_screen_expects(io_dbl)

        expect(io_dbl).to receive(:gets)
          .and_return("4\n").ordered
        
        expect(io_dbl).to receive(:print)
          .with("\nPlease type the customer's name?: ").ordered
        expect(io_dbl).to receive(:gets)
          .and_return("Billy-Bob").ordered
        expect(io_dbl).to receive(:print)
          .with("\nPlease type the order date [format: YYYY-MM-DD]?: ").ordered
        expect(io_dbl).to receive(:gets)
          .and_return("2023-04-30\n").ordered

        app.run

        repo = app.instance_variable_get(:@order_repository) 

        orders = repo.all

        expect(orders.length).to eq 5
        expect(orders.last.customer_name).to eq "Billy-Bob"
         # will need a loop break once loop is implemented
      end

       # re-prompts if date format is wrong? re-prompts with empty input?

    end

    context "when a user inputs 5" do
      it 'assigns an item to an order' do
        io_dbl = double :io
        # creating a new, unassigned item to add to an existing empty order
        new_item = Item.new
        new_item.name = "new_item"
        new_item.price = 6
        new_item.quantity = 6

        repo = ItemRepository.new
        repo.create(new_item)

        app = Application.new('shop_manager_test', io_dbl)

        welcome_screen_expects(io_dbl)

        expect(io_dbl).to receive(:gets)
          .and_return("5\n").ordered 

        expect(io_dbl).to receive(:print)
          .with("\nWhich order would you like to add to? [Input order #]: ").ordered     
        expect(io_dbl).to receive(:gets)
          .and_return("2\n").ordered     
        expect(io_dbl).to receive(:print)
          .with("\nWhich item would you like to add? [Input item #]: ").ordered     
        expect(io_dbl).to receive(:gets)
          .and_return("6\n").ordered     
    
        app.run

        app_item_repo = app.instance_variable_get(:@item_repository)

        items_on_order_two = app_item_repo.find_by_order(2)

        expect(items_on_order_two.length).to eq 1
        expect(items_on_order_two.first.name).to eq 'new_item'
        # will need a loop break once loop is implemented
      end

      # re-prompt if empty input? re-prompt if item already on order? re-prompt if item/order non-existent?
    end

    context "when a user inputs 6" do
      it 'exits the program' do
        io_dbl = double :io
        app = Application.new('shop_manager_test', io_dbl)

        welcome_screen_expects(io_dbl)
        expect(io_dbl).to receive(:gets)
          .and_return("6\n").ordered 

        expect { app.run }.to raise_error(SystemExit)
      end
    end

  end
end
