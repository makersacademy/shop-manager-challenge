require_relative "../app"
require_relative "../lib/item_repository"
require_relative "../lib/order_repository"

RSpec.describe Application do

  def reset_shop_manager_tables
    seed_sql = File.read('spec/shop_manager_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_shop_manager_tables
  end

  it 'displays items' do 
    @io = double :io
    @item_repository = double :item_repository
    @order_repository = double :order_repository  
    expect(@io).to receive(:puts).with("\n Welcome to the shop management program!")
    expect(@io).to receive(:puts).with("\n What do you want to do?\n \n 1 = list all shop items \n 2 = create a new item \n 3 = list all orders \n 4 = create a new order\n")
    expect(@io).to receive(:gets).and_return("1")
    expect(@io).to receive(:puts).with("Item ID: 1 - Item: Kombucha - Stawberry Peach - PPU: £9 - QTY: 10")
    expect(@io).to receive(:puts).with("Item ID: 2 - Item: Kimchi - PPU: £3 - QTY: 10")
    expect(@io).to receive(:puts).with("Item ID: 3 - Item: Salt Of The Earth Deodorant - PPU: £1 - QTY: 5")
    expect(@io).to receive(:puts).with("Item ID: 4 - Item: Spinach Gnocchi - PPU: £1 - QTY: 3")
    expect(@io).to receive(:puts).with("Item ID: 5 - Item: Provence Red Wine - PPU: £1 - QTY: 18")
    expect(@io).to receive(:puts).with("Item ID: 6 - Item: What The Cluck - PPU: £1 - QTY: 2")
    expect(@io).to receive(:puts).with("Item ID: 7 - Item: E-Cover Laundry Detergent - PPU: £3 - QTY: 8")
    expect(@io).to receive(:puts).with("Item ID: 8 - Item: Crunchy Peanut Butter - PPU: £1 - QTY: 2")
    expect(@io).to receive(:puts).with("Item ID: 9 - Item: Lavender Oil - PPU: £1 - QTY: 16")
    expect(@io).to receive(:puts).with("Item ID: 10 - Item: Dried Ginger - PPU: £2 - QTY: 5")
    app = Application.new('shop_manager_test', @io, @item_repository, @order_repository)
    app.run
  end

  it 'displays orders' do 
    @io = double :io
    @item_repository = double :item_repository
    @order_repository = double :order_repository  
    expect(@io).to receive(:puts).with("\n Welcome to the shop management program!")
    expect(@io).to receive(:puts).with("\n What do you want to do?\n \n 1 = list all shop items \n 2 = create a new item \n 3 = list all orders \n 4 = create a new order\n")
    expect(@io).to receive(:gets).and_return("3")

    expect(@io).to receive(:puts).with("Order ID: 1 - Customer: Joe Osborne - Date: 2022-09-23 13:10:11")
    expect(@io).to receive(:puts).with("Order ID: 2 - Customer: Dave Thomson - Date: 2022-09-29 10:10:11")
    expect(@io).to receive(:puts).with("Order ID: 3 - Customer: Jim Lennox - Date: 2022-09-30 19:07:07")
    app = Application.new('shop_manager_test', @io, @item_repository, @order_repository)
    app.run
  end

  it "creates an item" do
    @io = double :io
    expect(@io).to receive(:puts).with("\n Welcome to the shop management program!")
    expect(@io).to receive(:puts).with("\n What do you want to do?\n \n 1 = list all shop items \n 2 = create a new item \n 3 = list all orders \n 4 = create a new order\n")
    expect(@io).to receive(:gets).and_return("2")
    expect(@io).to receive(:puts).with("Please enter item ID:")
    expect(@io).to receive(:gets).and_return("7")
    expect(@io).to receive(:puts).with("Please enter item name:")
    expect(@io).to receive(:gets).and_return("Himalayan Salt")
    expect(@io).to receive(:puts).with("Please enter unit price (£):")
    expect(@io).to receive(:gets).and_return("8")
    expect(@io).to receive(:puts).with("Please enter stock quantity:")
    expect(@io).to receive(:gets).and_return("40")
    app = Application.new('shop_manager_test', @io, ItemRepository.new, OrderRepository.new)
    app.run
  end

  it "creates an order" do
    @io = double :io
    expect(@io).to receive(:puts).with("\n Welcome to the shop management program!")
    expect(@io).to receive(:puts).with("\n What do you want to do?\n \n 1 = list all shop items \n 2 = create a new item \n 3 = list all orders \n 4 = create a new order\n")
    expect(@io).to receive(:gets).and_return("4")
    expect(@io).to receive(:puts).with("Please enter order ID:")
    expect(@io).to receive(:gets).and_return("7")
    expect(@io).to receive(:puts).with("Please enter customer name:")
    expect(@io).to receive(:gets).and_return("Lola Bowland")
    app = Application.new('shop_manager_test', @io, ItemRepository.new, OrderRepository.new)
    app.run
  end
end
