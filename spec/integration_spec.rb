require 'application'
require 'item_repository.rb'
require 'order_repository.rb'

# Here's an example of the terminal output your program should generate:
# Welcome to the shop management program!

# What do you want to do?
#   1 = list all shop items
#   2 = create a new item
#   3 = list all orders
#   4 = create a new order
#   5 = assign an item to an order
#   6 = exit

# 1 [enter]

# Here's a list of all shop items:

#  #1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30
#  #2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15
#  (...)

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
        .with( "1 item_one - Unit price: 1 - Quantity: 1\n2 item_two - Unit price: 2 - Quantity: 2\n3 item_three - Unit price: 3 - Quantity: 3\n4 item_four - Unit price: 4 - Quantity: 4\n5 item_five - Unit price: 5 - Quantity: 5\n").ordered
        app.run
      end
    end  

    context "when a user inputs 2" do
      it 'creates a new item' do
        # ..
      end
    end  

    context "when a user inputs 3" do
      it 'lists all orders' do
        # ..
      end
    end

    context "when a user inputs 4" do
      it 'creates a new order' do
        # ..
      end
    end

    context "when a user inputs 5" do
      it 'assigns an item to an order' do
        # ..
      end
    end

    context "when a user inputs 6" do
      it 'exits the program' do
        # ..
      end
    end

  end
end