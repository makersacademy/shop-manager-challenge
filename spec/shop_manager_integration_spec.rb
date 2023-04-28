require_relative '../app'

describe "shop manager" do
  def reset_shop_manager_table
    seed_sql = File.read('spec/seeds_shop_manager_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_shop_manager_table
  end

  it "returns a list of all shop items when user selects 1" do
    io = double :io
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\n").ordered
    expect(io).to receive(:puts).with("What do you want to do?").ordered
    expect(io).to receive(:puts).with(" 1 = list all shop items").ordered
    expect(io).to receive(:puts).with(" 2 = create a new item").ordered
    expect(io).to receive(:puts).with(" 3 = list all orders").ordered
    expect(io).to receive(:puts).with(" 4 = create a new order").ordered
    expect(io).to receive(:puts).with("\n").ordered
    expect(io).to receive(:gets).and_return("1").ordered
    expect(io).to receive(:puts).with("\n").ordered
    expect(io).to receive(:puts).with("Here's a list of all shop items:").ordered
    expect(io).to receive(:puts).with("\n").ordered
    expect(io).to receive(:puts).with("#1 Super Shark Vacuum Cleaner - Unit price: $99.99 - Quantity: 30").ordered
    expect(io).to receive(:puts).with("#2 Makerspresso - Unit price: $69.00 - Quantity: 15").ordered

    app = Application.new('shop_manager_test', io, ShopItemRepository.new, OrderRepository.new)
    app.run
  end

  it "creates a new item when user selects 2" do
    io = double :io
    shop_items = ShopItemRepository.new
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\n").ordered
    expect(io).to receive(:puts).with("What do you want to do?").ordered
    expect(io).to receive(:puts).with(" 1 = list all shop items").ordered
    expect(io).to receive(:puts).with(" 2 = create a new item").ordered
    expect(io).to receive(:puts).with(" 3 = list all orders").ordered
    expect(io).to receive(:puts).with(" 4 = create a new order").ordered
    expect(io).to receive(:puts).with("\n").ordered
    expect(io).to receive(:gets).and_return("2").ordered
    expect(io).to receive(:puts).with("\n").ordered
    expect(io).to receive(:puts).with("Please enter the details of the item you want to create").ordered
    expect(io).to receive(:print).with("Name: ").ordered
    expect(io).to receive(:gets).and_return("Dyson Airwrap").ordered
    expect(io).to receive(:print).with("Unit price: ").ordered
    expect(io).to receive(:gets).and_return("300").ordered
    expect(io).to receive(:print).with("Quantity: ").ordered
    expect(io).to receive(:gets).and_return("5").ordered
    expect(io).to receive(:puts).with("Item created").ordered

    app = Application.new('shop_manager_test', io, shop_items, OrderRepository.new)
    app.run

    expect(shop_items.all.last.name).to eq "Dyson Airwrap"
    expect(shop_items.all.last.unit_price).to eq "$300.00"
    expect(shop_items.all.last.quantity).to eq "5"
  end

  it "returns a list of all order items when user selects 3" do
    io = double :io
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\n").ordered
    expect(io).to receive(:puts).with("What do you want to do?").ordered
    expect(io).to receive(:puts).with(" 1 = list all shop items").ordered
    expect(io).to receive(:puts).with(" 2 = create a new item").ordered
    expect(io).to receive(:puts).with(" 3 = list all orders").ordered
    expect(io).to receive(:puts).with(" 4 = create a new order").ordered
    expect(io).to receive(:puts).with("\n").ordered
    expect(io).to receive(:gets).and_return("3").ordered
    expect(io).to receive(:puts).with("\n").ordered
    expect(io).to receive(:puts).with("Here's a list of all orders:").ordered
    expect(io).to receive(:puts).with("\n").ordered
    expect(io).to receive(:puts).with("* Order id: 1 - Customer name: Sarah").ordered
    expect(io).to receive(:puts).with("  Date placed: 06/04/2023 - Item id: 1").ordered
    expect(io).to receive(:puts).with("* Order id: 2 - Customer name: Fred").ordered
    expect(io).to receive(:puts).with("  Date placed: 12/03/2023 - Item id: 2").ordered

    app = Application.new('shop_manager_test', io, ShopItemRepository.new, OrderRepository.new)
    app.run
  end

  it "creates a new order when user selects 4" do
    io = double :io
    orders = OrderRepository.new
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\n").ordered
    expect(io).to receive(:puts).with("What do you want to do?").ordered
    expect(io).to receive(:puts).with(" 1 = list all shop items").ordered
    expect(io).to receive(:puts).with(" 2 = create a new item").ordered
    expect(io).to receive(:puts).with(" 3 = list all orders").ordered
    expect(io).to receive(:puts).with(" 4 = create a new order").ordered
    expect(io).to receive(:puts).with("\n").ordered
    expect(io).to receive(:gets).and_return("4").ordered
    expect(io).to receive(:puts).with("\n").ordered
    expect(io).to receive(:puts).with("Please enter the order details").ordered
    expect(io).to receive(:print).with("Customer name: ").ordered
    expect(io).to receive(:gets).and_return("Bob").ordered
    expect(io).to receive(:print).with("Date placed (YYYY-MM-DD HH:MM:SS): ").ordered
    expect(io).to receive(:gets).and_return("2023-04-30 18:32:02").ordered
    expect(io).to receive(:print).with("Shop Item Id: ").ordered
    expect(io).to receive(:gets).and_return("2").ordered
    expect(io).to receive(:puts).with("Order added").ordered

    app = Application.new('shop_manager_test', io, ShopItemRepository, orders)
    app.run

    expect(orders.all.last.customer_name).to eq "Bob"
    expect(orders.all.last.date_placed).to eq "2023-04-30 18:32:02"
    expect(orders.all.last.shop_item_id).to eq "2"
  end

  it "returns an error message if choice is not on menu" do
    io = double :io
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("\n").ordered
    expect(io).to receive(:puts).with("What do you want to do?").ordered
    expect(io).to receive(:puts).with(" 1 = list all shop items").ordered
    expect(io).to receive(:puts).with(" 2 = create a new item").ordered
    expect(io).to receive(:puts).with(" 3 = list all orders").ordered
    expect(io).to receive(:puts).with(" 4 = create a new order").ordered
    expect(io).to receive(:puts).with("\n").ordered
    expect(io).to receive(:gets).and_return("5").ordered
    expect(io).to receive(:puts).with("\n").ordered
    expect(io).to receive(:puts).with("Sorry I didn't understand that.").ordered

    app = Application.new('shop_manager_test', io, ShopItemRepository, OrderRepository.new)
    app.run
  end
end
