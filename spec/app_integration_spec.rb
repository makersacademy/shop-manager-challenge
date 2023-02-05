require './app'
require 'item_repository'
require 'order_repository'

RSpec.describe 'class Application' do

  def reset_tables
    seed_sql = File.read('spec/seeds_shop_db.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_tables
  end
 
  it "displays the welcome message" do
    item = ItemRepository.new
    order = OrderRepository.new
    terminal = double :terminal
    expect(terminal).to receive(:puts).with("Welcome to the shop management program!")
    expect(terminal).to receive(:puts).with("What do you want to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order")
    expect(terminal).to receive(:gets).and_return("4")
    shop = Application.new('shop_manager', terminal, item, order)
    shop.welcome_message
  end

  it 'displays the list of all items' do
    item = ItemRepository.new
    order = OrderRepository.new
    terminal = double :terminal
    expect(terminal).to receive(:puts).with("Here is the list of items:").ordered
    expect(terminal).to receive(:puts).with("ID: 1, Butter Bear, Price: 16, Quantity: 14").ordered
    expect(terminal).to receive(:puts).with("ID: 2, Greek Yoghurt, Price: 6, Quantity: 4").ordered
    expect(terminal).to receive(:puts).with("ID: 3, Curry Rice, Price: 15, Quantity: 3").ordered
    expect(terminal).to receive(:puts).with("ID: 4, Chocolate, Price: 7, Quantity: 9").ordered
    shop = Application.new('shop_manager', terminal, item, order)
    shop.list_items
  end

  it 'creates a new item' do
    item_repo = ItemRepository.new
    order_repo = OrderRepository.new
    terminal = double :terminal
    expect(terminal).to receive(:puts).with("Enter item ID")
    expect(terminal).to receive(:gets).and_return("5")
    expect(terminal).to receive(:puts).with("Enter the name of item")
    expect(terminal).to receive(:gets).and_return("Onion Bhaji")
    expect(terminal).to receive(:puts).with("Enter the price of the item(in a whole number)")
    expect(terminal).to receive(:gets).and_return("6")
    expect(terminal).to receive(:puts).with("Enter item quantity")
    expect(terminal).to receive(:gets).and_return("10")
    expect(terminal).to receive(:puts).with("New item added")
    shop = Application.new('shop_manager', terminal, item_repo, order_repo)
    shop.create_item
  end

  it 'displays the list of all orders' do
    item = ItemRepository.new
    order = OrderRepository.new
    terminal = double :terminal
    expect(terminal).to receive(:puts).with("Here is the list of orders:").ordered
    expect(terminal).to receive(:puts).with("* Harry ID: 1 Item ID: 3").ordered
    expect(terminal).to receive(:puts).with("* Ron ID: 2 Item ID: 1").ordered
    expect(terminal).to receive(:puts).with("* Hermoine ID: 3 Item ID: 4").ordered
    expect(terminal).to receive(:puts).with("* James ID: 4 Item ID: 2").ordered
    shop = Application.new('shop_manager', terminal, item, order)
    shop.list_orders
  end

  it 'creates a new item' do
    item_repo = ItemRepository.new
    order_repo = OrderRepository.new
    terminal = double :terminal
    expect(terminal).to receive(:puts).with("Enter order ID")
    expect(terminal).to receive(:gets).and_return("5")
    expect(terminal).to receive(:puts).with("Enter customer name")
    expect(terminal).to receive(:gets).and_return("Professor Snape")
    expect(terminal).to receive(:puts).with("Enter date of order(yyyy-mm-dd))")
    expect(terminal).to receive(:gets).and_return("2023-12-08")
    expect(terminal).to receive(:puts).with("Enter item ID")
    expect(terminal).to receive(:gets).and_return("4")
    expect(terminal).to receive(:puts).with("New order added")
    shop = Application.new('shop_manager', terminal, item_repo, order_repo)
    shop.create_order
  end
end