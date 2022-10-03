require '/Users/saritaradia/Desktop/Projects/shop-manager-challenge/lib/order_repository.rb'
require '/Users/saritaradia/Desktop/Projects/shop-manager-challenge/lib/order.rb'
require '/Users/saritaradia/Desktop/Projects/shop-manager-challenge/lib/item_repository.rb'
require '/Users/saritaradia/Desktop/Projects/shop-manager-challenge/lib/item.rb'
require '/Users/saritaradia/Desktop/Projects/shop-manager-challenge/app.rb'

RSpec.describe Application do
  def reset_itemsorders_table
    seed_sql = File.read('spec/seeds_itemsorders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_itemsorders_table
  end

  it "When user input is 1, it lists all items" do
    io = double :terminal_io
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("What do you want to do?").ordered
    expect(io).to receive(:puts).with("1 = list all shop items").ordered
    expect(io).to receive(:puts).with("2 = create a new item").ordered
    expect(io).to receive(:puts).with("3 = list all orders").ordered
    expect(io).to receive(:puts).with("4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("1").ordered

    expect(io).to receive(:puts).with("1 - Item name:Chips Unit price:$2.99 Quantity:1")
    expect(io).to receive(:puts).with("2 - Item name:Pizza Unit price:$3.49 Quantity:2")
    expect(io).to receive(:puts).with("3 - Item name:Sandwich Unit price:$1.99 Quantity:3")

    list_items = Application.new('shop_manager_test', io, ItemRepository.new, OrderRepository.new)
    list_items.run
  end

  it "When user input is 2, it creates a new item" do
    io = double :terminal_io

    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("What do you want to do?").ordered
    expect(io).to receive(:puts).with("1 = list all shop items").ordered
    expect(io).to receive(:puts).with("2 = create a new item").ordered
    expect(io).to receive(:puts).with("3 = list all orders").ordered
    expect(io).to receive(:puts).with("4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("2").ordered

    expect(io).to receive(:puts).with("What is the item id?").ordered
    expect(io).to receive(:gets).and_return("4").ordered
    expect(io).to receive(:puts).with("What would you like to name the item?").ordered
    expect(io).to receive(:gets).and_return("Oreo").ordered
    expect(io).to receive(:puts).with("What is the unit price?").ordered
    expect(io).to receive(:gets).and_return("$2.99").ordered
    expect(io).to receive(:puts).with("What is the quantity of this item?").ordered
    expect(io).to receive(:gets).and_return("10").ordered
    expect(io).to receive(:puts).with("Item created").ordered

    list_items = Application.new('shop_manager_test', io, ItemRepository.new, OrderRepository.new)
    list_items.run
  end

  it "When user input is 3, it lists all orders" do
    io = double :terminal_io
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("What do you want to do?").ordered
    expect(io).to receive(:puts).with("1 = list all shop items").ordered
    expect(io).to receive(:puts).with("2 = create a new item").ordered
    expect(io).to receive(:puts).with("3 = list all orders").ordered
    expect(io).to receive(:puts).with("4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("3").ordered

    expect(io).to receive(:puts).with("1: Customer name:Sara | Order date: 1995-09-01")
    expect(io).to receive(:puts).with("2: Customer name:Anne | Order date: 2022-12-12")


    list_items = Application.new('shop_manager_test', io, ItemRepository.new, OrderRepository.new)
    list_items.run
  end

  it "When user input is 4, it creates a new order" do
    io = double :terminal_io

    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("What do you want to do?").ordered
    expect(io).to receive(:puts).with("1 = list all shop items").ordered
    expect(io).to receive(:puts).with("2 = create a new item").ordered
    expect(io).to receive(:puts).with("3 = list all orders").ordered
    expect(io).to receive(:puts).with("4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("4").ordered

    expect(io).to receive(:puts).with("What is the order id?").ordered
    expect(io).to receive(:gets).and_return("4").ordered
    expect(io).to receive(:puts).with("What is the customer name?").ordered
    expect(io).to receive(:gets).and_return("Tammy").ordered
    expect(io).to receive(:puts).with("What is the order date?").ordered
    expect(io).to receive(:gets).and_return("2022-03-02").ordered
    expect(io).to receive(:puts).with("Order created").ordered

    list_items = Application.new('shop_manager_test', io, ItemRepository.new, OrderRepository.new)
    list_items.run
  end

end