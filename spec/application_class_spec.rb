require_relative '../app'

def reset_tables
  seed_sql = File.read('spec/seed.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe Application do
  before(:each) do
    reset_tables
  end
  it "prints a list of items" do
    io_dbl = double :io
    expect(io_dbl).to receive(:puts).with("Welcome to the shop management program!")
    expect(io_dbl).to receive(:puts).with("What do you want to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n")
    expect(io_dbl).to receive(:gets).and_return("1\n")
    expect(io_dbl).to receive(:puts).with("Here's a list of all shop items:")
    expect(io_dbl).to receive(:puts).with("#1 Strength Potion - Item price: 8.99 - Quantity: 100")
    expect(io_dbl).to receive(:puts).with("#2 Med Kit - Item price: 25.5 - Quantity: 43")
      

    item_repository = ItemRepository.new
    order_repository = OrderRepository.new
    app = Application.new("shop_manager_test", io_dbl, item_repository, order_repository)
    app.run
  end
  it "creates a new item entry" do
    io_dbl = double :io
    expect(io_dbl).to receive(:puts).with("Welcome to the shop management program!")
    expect(io_dbl).to receive(:puts).with("What do you want to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n")
    expect(io_dbl).to receive(:gets).and_return("2\n")
    expect(io_dbl).to receive(:puts).with("Enter item details:")
    expect(io_dbl).to receive(:gets).and_return("Bronze Shield, 10.20, 344\n")
    expect(io_dbl).to receive(:puts).with("Item Created!")

    item_repository = ItemRepository.new
    order_repository = OrderRepository.new
    app = Application.new("shop_manager_test", io_dbl, item_repository, order_repository)
    app.run
  end
  it "prints a list of orders" do
    io_dbl = double :io
    expect(io_dbl).to receive(:puts).with("Welcome to the shop management program!")
    expect(io_dbl).to receive(:puts).with("What do you want to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n")
    expect(io_dbl).to receive(:gets).and_return("3\n")
    expect(io_dbl).to receive(:puts).with("Here's a list of all orders:")
    expect(io_dbl).to receive(:puts).with("Order id: #1 Sally Smith, 2022-07-04, item_id: 1")
    expect(io_dbl).to receive(:puts).with("Order id: #2 Kevin Mack, 2022-07-02, item_id: 2")
      
    item_repository = ItemRepository.new
    order_repository = OrderRepository.new
    app = Application.new("shop_manager_test", io_dbl, item_repository, order_repository)
    app.run
  end
  it "creates a new order entry" do
    io_dbl = double :io
    expect(io_dbl).to receive(:puts).with("Welcome to the shop management program!")
    expect(io_dbl).to receive(:puts).with("What do you want to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n")
    expect(io_dbl).to receive(:gets).and_return("4\n")
    expect(io_dbl).to receive(:puts).with("Enter order details:")
    expect(io_dbl).to receive(:gets).and_return("Tess Bage| January 4, 2022| 2\n")
    expect(io_dbl).to receive(:puts).with("Order Created!")

    item_repository = ItemRepository.new
    order_repository = OrderRepository.new
    app = Application.new("shop_manager_test", io_dbl, item_repository, order_repository)
    app.run
  end
end
