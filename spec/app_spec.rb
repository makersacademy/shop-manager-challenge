require_relative '../app'

RSpec.describe Application do
  it "lists all the items when prompted" do
    terminal = double :terminal
    expect(terminal).to receive(:puts).with('Welcome to the shop management program!').ordered
    expect(terminal).to receive(:puts).with('What would you like to do?').ordered
    expect(terminal).to receive(:puts).with('1 - List all shop items').ordered
    expect(terminal).to receive(:puts).with('2 - Create a new item').ordered
    expect(terminal).to receive(:puts).with('3 - List all shop orders').ordered
    expect(terminal).to receive(:puts).with('4 - Create a new order').ordered
    expect(terminal).to receive(:puts).with("Enter your choice:").ordered

    expect(terminal).to receive(:gets).and_return('1').ordered
    expect(terminal).to receive(:puts).with("Here is the list of shop items:").ordered

    expect(terminal).to receive(:puts).with("#1 ball - unit price: 10 - quantity: 100").ordered
    expect(terminal).to receive(:puts).with("#2 shoes - unit price: 50 - quantity: 200").ordered
    expect(terminal).to receive(:puts).with("#3 socks - unit price: 5 - quantity: 100").ordered
    expect(terminal).to receive(:puts).with("#4 jersey - unit price: 70 - quantity: 50").ordered
    expect(terminal).to receive(:puts).with("#5 shorts - unit price: 20 - quantity: 300").ordered
    expect(terminal).to receive(:puts).with("#6 hat - unit price: 15 - quantity: 150").ordered

    item_repository = ItemRepository.new
    orders_repository = OrdersRepository.new 
    app = Application.new('shop_manager_test', terminal, item_repository, orders_repository)
    app.run
  end

  it "creates a new item when 2 is selected" do
    terminal = double :terminal
    expect(terminal).to receive(:puts).with('Welcome to the shop management program!').ordered
    expect(terminal).to receive(:puts).with('What would you like to do?').ordered
    expect(terminal).to receive(:puts).with('1 - List all shop items').ordered
    expect(terminal).to receive(:puts).with('2 - Create a new item').ordered
    expect(terminal).to receive(:puts).with('3 - List all shop orders').ordered
    expect(terminal).to receive(:puts).with('4 - Create a new order').ordered
    expect(terminal).to receive(:puts).with("Enter your choice:").ordered

    expect(terminal).to receive(:gets).and_return('2').ordered
    expect(terminal).to receive(:puts).with("Enter the item name:").ordered
    expect(terminal).to receive(:gets).and_return("boots").ordered
    expect(terminal).to receive(:puts).with("Enter the item unit price:").ordered
    expect(terminal).to receive(:gets).and_return("100").ordered
    expect(terminal).to receive(:puts).with("Enter the item quantity:").ordered
    expect(terminal).to receive(:gets).and_return("60").ordered
    expect(terminal).to receive(:puts).with("Item created").ordered

    item_repository = ItemRepository.new
    orders_repository = OrdersRepository.new 
    app = Application.new('shop_manager_test', terminal, item_repository, orders_repository)
    app.run
  end

  it "lists all shop orders" do
    terminal = double :terminal
    expect(terminal).to receive(:puts).with('Welcome to the shop management program!').ordered
    expect(terminal).to receive(:puts).with('What would you like to do?').ordered
    expect(terminal).to receive(:puts).with('1 - List all shop items').ordered
    expect(terminal).to receive(:puts).with('2 - Create a new item').ordered
    expect(terminal).to receive(:puts).with('3 - List all shop orders').ordered
    expect(terminal).to receive(:puts).with('4 - Create a new order').ordered
    expect(terminal).to receive(:puts).with("Enter your choice:").ordered

    expect(terminal).to receive(:gets).and_return('3').ordered
    expect(terminal).to receive(:puts).with("Here is the list of shop orders:").ordered

    expect(terminal).to receive(:puts).with("#1 Lamar - date: 2022-11-01").ordered
    expect(terminal).to receive(:puts).with("#2 Justin - date: 2022-11-10").ordered
    expect(terminal).to receive(:puts).with("#3 Patrick - date: 2022-11-22").ordered
    expect(terminal).to receive(:puts).with("#4 Josh - date: 2022-11-12").ordered
    expect(terminal).to receive(:puts).with("#5 Kirk - date: 2022-11-15").ordered
    expect(terminal).to receive(:puts).with("#6 Fields - date: 2022-11-05").ordered

    item_repository = ItemRepository.new
    orders_repository = OrdersRepository.new 
    app = Application.new('shop_manager_test', terminal, item_repository, orders_repository)
    app.run
  end 

  it "creates a new item when 2 is selected" do
    terminal = double :terminal
    expect(terminal).to receive(:puts).with('Welcome to the shop management program!').ordered
    expect(terminal).to receive(:puts).with('What would you like to do?').ordered
    expect(terminal).to receive(:puts).with('1 - List all shop items').ordered
    expect(terminal).to receive(:puts).with('2 - Create a new item').ordered
    expect(terminal).to receive(:puts).with('3 - List all shop orders').ordered
    expect(terminal).to receive(:puts).with('4 - Create a new order').ordered
    expect(terminal).to receive(:puts).with("Enter your choice:").ordered

    expect(terminal).to receive(:gets).and_return('4').ordered
    expect(terminal).to receive(:puts).with("Enter the order name:").ordered
    expect(terminal).to receive(:gets).and_return("Jefferson").ordered
    expect(terminal).to receive(:puts).with("Enter the order date:").ordered
    expect(terminal).to receive(:gets).and_return("2022-11-20").ordered
    expect(terminal).to receive(:puts).with("Order created").ordered

    item_repository = ItemRepository.new
    orders_repository = OrdersRepository.new 
    app = Application.new('shop_manager_test', terminal, item_repository, orders_repository)
    app.run
  end
end 
