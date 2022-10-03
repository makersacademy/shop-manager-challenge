require_relative "../app.rb"
require "colorize"

def reset_tables
  seed_sql = File.read('spec/orders_items_seeds.sql')
  connection = PG.connect({ host: ENV['HOST'], dbname: 'shop_test', user: 'postgres', password: ENV['PASSWORD'] })
  connection.exec(seed_sql)
end

RSpec.describe Application do
  before(:each) do
    reset_tables
  end

  let(:io) {double :io}
  let(:app) {Application.new('shop_test', io, ItemRepository.new, OrderRepository.new)}

  it "Loops until valid option selected and then exits" do

    expect(io).to receive(:puts).with("\n")
    expect(io).to receive(:puts).with("Welcome to the shop management program!".colorize(:blue))
    expect(io).to receive(:puts).with("\n")
    expect(io).to receive(:puts).with("Please select one of the options:".colorize(:blue))
    expect(io).to receive(:puts).with("1 = list all shop items")
    expect(io).to receive(:puts).with("2 = create a new item")
    expect(io).to receive(:puts).with("3 = list all orders")
    expect(io).to receive(:puts).with("4 = create a new order")
    expect(io).to receive(:puts).with("5 = exit program")
    expect(io).to receive(:puts).with("\n")
    expect(io).to receive(:gets).and_return("6")
    expect(io).to receive(:puts).with("You selected option 6.".colorize(:blue))
    expect(io).to receive(:puts).with("\n")
    expect(io).to receive(:puts).with("Invalid! Please enter valid option.".colorize(:red))
    expect(io).to receive(:puts).with("\n")
    expect(io).to receive(:puts).with("Please select one of the options:".colorize(:blue))
    expect(io).to receive(:puts).with("1 = list all shop items")
    expect(io).to receive(:puts).with("2 = create a new item")
    expect(io).to receive(:puts).with("3 = list all orders")
    expect(io).to receive(:puts).with("4 = create a new order")
    expect(io).to receive(:puts).with("5 = exit program")
    expect(io).to receive(:puts).with("\n")
    expect(io).to receive(:gets).and_return("5")
    expect(io).to receive(:puts).with("You selected option 5.".colorize(:blue))
    expect(io).to receive(:puts).with("\n")

    expect{ app.run }.to raise_error(SystemExit)
  end

  it "Prints the list of all items in stock" do
    expect(io).to receive(:puts).with("ITEMS IN STOCK:".colorize(:blue))
    expect(io).to receive(:puts).with("\n")
    expect(io).to receive(:puts).with("#1 Russell Hobbs Microwave - Unit price: $69.00 - Quantity: 10")
    expect(io).to receive(:puts).with("#2 Bush Electric Oven - Unit price: $139.00 - Quantity: 5")
    expect(io).to receive(:puts).with("#3 Rug Doctor Carpet Cleaner - Unit price: $134.99 - Quantity: 8")

    app.list_items
  end

  it "Print the list of current orders" do 
    expect(io).to receive(:puts).with("CURRENT ORDERS:".colorize(:blue))
    expect(io).to receive(:puts).with("\n")
    expect(io).to receive(:puts).with("#1 Kate - Order date: 2022-09-20 - Items:")
    expect(io).to receive(:puts).with("- #2 Bush Electric Oven - Price: $139.00")
    expect(io).to receive(:puts).with("- #3 Rug Doctor Carpet Cleaner - Price: $134.99")
    expect(io).to receive(:puts).with("\n")
    expect(io).to receive(:puts).with("#2 John - Order date: 2022-09-18 - Items:")
    expect(io).to receive(:puts).with("- #2 Bush Electric Oven - Price: $139.00")
    expect(io).to receive(:puts).with("\n")
    expect(io).to receive(:puts).with("#3 Josh - Order date: 2022-09-20 - Items:")
    expect(io).to receive(:puts).with("- #1 Russell Hobbs Microwave - Price: $69.00")
    expect(io).to receive(:puts).with("- #3 Rug Doctor Carpet Cleaner - Price: $134.99")
    expect(io).to receive(:puts).with("\n")

    app.list_orders
  end

  it "Creates a new item" do
    expect(io).to receive(:puts).with("Enter item name:")
    expect(io).to receive(:gets).and_return("Test item")
    expect(io).to receive(:puts).with("Enter item price:")
    expect(io).to receive(:gets).and_return("aa")
    expect(io).to receive(:puts).with("Please enter valid price.".colorize(:red))
    expect(io).to receive(:gets).and_return("0")
    expect(io).to receive(:puts).with("Please enter valid price.".colorize(:red))
    expect(io).to receive(:gets).and_return("100.54")
    expect(io).to receive(:puts).with("Enter item quantity:")
    expect(io).to receive(:gets).and_return("b")
    expect(io).to receive(:puts).with("Please enter valid quantity.".colorize(:red))
    expect(io).to receive(:gets).and_return("0")
    expect(io).to receive(:puts).with("Please enter valid quantity.".colorize(:red))
    expect(io).to receive(:gets).and_return("1")
    expect(io).to receive(:puts).with("Test item was added in stock.".colorize(:green))

    app.create_item
  end

  it "Creates a new order linked to item" do
    expect(io).to receive(:puts).with("Enter customer name:")
    expect(io).to receive(:gets).and_return("Test name")
    expect(io).to receive(:puts).with("Enter item ordered:")
    expect(io).to receive(:gets).and_return("4")
    expect(io).to receive(:puts).with("Please enter valid item in stock.".colorize(:red))
    expect(io).to receive(:gets).and_return("3")
    expect(io).to receive(:puts).with("Order for Test name was created.".colorize(:green))
    expect(io).to receive(:puts).with("Rug Doctor Carpet Cleaner quantity in stock was reduced by one.".colorize(:green))

    app.create_order
  end


end