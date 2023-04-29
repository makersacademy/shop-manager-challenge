require_relative '../app'
require 'item_repository'
require 'order_repository'

def reset_shop_manager
  seed_sql = File.read('./spec/seeds_shop_manager.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do 
    reset_shop_manager
  end

  it "Asks user what they want to do, and returns 1 - list of all shop items" do
    io = double :io
    item_repository = ItemRepository.new
    order_repository = OrderRepository.new

    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("What do you want to do?").ordered
    expect(io).to receive(:puts).with("  1 = list all shop items").ordered
    expect(io).to receive(:puts).with("  2 = create a new item").ordered
    expect(io).to receive(:puts).with("  3 = list all orders").ordered
    expect(io).to receive(:puts).with("  4 = create a new order").ordered

    expect(io).to receive(:gets).and_return("1").ordered
    expect(io).to receive(:puts).with("#1 Correction tape - Unit price: £4.95 - Quantity: 26").ordered
    expect(io).to receive(:puts).with("#2 Cute eraser - Unit price: £3.25 - Quantity: 14").ordered

    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.run
  end

  it "2 - Creates a new item" do
    io = double :io
    item_repository = ItemRepository.new
    order_repository = OrderRepository.new

    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("What do you want to do?").ordered
    expect(io).to receive(:puts).with("  1 = list all shop items").ordered
    expect(io).to receive(:puts).with("  2 = create a new item").ordered
    expect(io).to receive(:puts).with("  3 = list all orders").ordered
    expect(io).to receive(:puts).with("  4 = create a new order").ordered

    expect(io).to receive(:gets).and_return("2").ordered
    expect(io).to receive(:puts).with("Please enter the item's name").ordered
    expect(io).to receive(:gets).and_return("Rainbow sharpie").ordered
    expect(io).to receive(:puts).with("Please enter the item's unit price").ordered
    expect(io).to receive(:gets).and_return("13.99").ordered
    expect(io).to receive(:puts).with("Please enter the item's quantity").ordered
    expect(io).to receive(:gets).and_return("50").ordered
    expect(io).to receive(:puts).with("Item successfully added to the stop!").ordered

    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.run
  end

  it "Returns 3 - lists all orders" do
    io = double :io
    item_repository = ItemRepository.new
    order_repository = OrderRepository.new

    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("What do you want to do?").ordered
    expect(io).to receive(:puts).with("  1 = list all shop items").ordered
    expect(io).to receive(:puts).with("  2 = create a new item").ordered
    expect(io).to receive(:puts).with("  3 = list all orders").ordered
    expect(io).to receive(:puts).with("  4 = create a new order").ordered

    expect(io).to receive(:gets).and_return("3").ordered
    expect(io).to receive(:puts).with("#1 David - Date: 2023-03-22 - Item: Correction tape").ordered
    expect(io).to receive(:puts).with("#2 Anna - Date: 2023-04-25 - Item: Cute eraser").ordered

    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.run
  end

end
