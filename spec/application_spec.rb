require 'item'
require 'item_repository'
require 'order'
require 'order_repository'
require 'application'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'items_orders_test' })
  connection.exec(seed_sql)
end

def create_app(io)
  return Application.new(
    'items_orders_test',
    io,
    @item_repository,
    @order_repository
  )
end

RSpec.describe Application do
  before(:each) do 
    reset_tables
    @item_repository = ItemRepository.new
    @order_repository = OrderRepository.new
  end

  it "prints the menu" do
    io = double :io
    expect(io).to receive(:puts)
      .with('Welcome to the shop!')
        .ordered
    expect(io).to receive(:puts)
      .with('What would you like to do?')
        .ordered
    expect(io).to receive(:puts)
      .with('1 - List all items')
        .ordered
    expect(io).to receive(:puts)
      .with('2 - List all items attached to an order')
        .ordered
    expect(io).to receive(:puts)
      .with('3 - Create a new item')
        .ordered
    expect(io).to receive(:puts)
      .with('4 - List all orders')
        .ordered
    expect(io).to receive(:puts)
      .with('5 - List all orders that contain a specific item')
        .ordered
    expect(io).to receive(:puts)
      .with('6 - Create a new order')
        .ordered
    expect(io).to receive(:puts)
      .with('7 - Exit')
        .ordered

    app = create_app(io)
    app.print_menu
  end

  it "actions on user selection" do
    io = double :io
    app = create_app(io)

    expect(app).to receive(:print_items).ordered
    app.do_selection('1')

    expect(app).to receive(:print_items_by_order).ordered
    app.do_selection('2')

    expect(app).to receive(:create_item).ordered
    app.do_selection('3')

    expect(app).to receive(:print_orders).ordered
    app.do_selection('4')

    expect(app).to receive(:print_orders_by_item).ordered
    app.do_selection('5')

    expect(app).to receive(:create_order).ordered
    app.do_selection('6')

    expect(io).to receive(:exit).ordered
    app.do_selection('7')
  end

  it "prints all items" do
    io = double :io
    expect(io).to receive(:puts)
      .with('All items:')
        .ordered
    expect(io).to receive(:puts)
      .with("Pizza - Price: £9.99 - Quantity: 100")
        .ordered
    expect(io).to receive(:puts)
      .with("Cake - Price: £4.50 - Quantity: 20")
        .ordered
    expect(io).to receive(:puts)
      .with("Chips - Price: £2.50 - Quantity: 50")
        .ordered
    expect(io).to receive(:puts)
      .with("Burger - Price: £8.49 - Quantity: 12")
        .ordered
    expect(io).to receive(:puts)
      .with("Salad - Price: £0.99 - Quantity: 2")
        .ordered
    expect(io).to receive(:puts)
      .with("Hotdog - Price: £12.50 - Quantity: 99")
        .ordered
    expect(io).to receive(:puts)
      .with("Spagbol - Price: £19.99 - Quantity: 59")
        .ordered

    app = create_app(io)
    app.print_items
  end

  it "prints items by order" do
    io = double :io
    expect(io).to receive(:puts)
      .with("What order do you want to see the items for?")
        .ordered
    expect(io).to receive(:gets)
      .and_return('1')
        .ordered
    expect(io).to receive(:puts)
      .with("Pizza - Price: £9.99 - Quantity: 100")
        .ordered
    expect(io).to receive(:puts)
      .with("Cake - Price: £4.50 - Quantity: 20")
        .ordered
    expect(io).to receive(:puts)
      .with("Chips - Price: £2.50 - Quantity: 50")
        .ordered
    expect(io).to receive(:puts)
     .with("Salad - Price: £0.99 - Quantity: 2")
       .ordered   
    app = create_app(io)
    app.print_items_by_order
  end

  it "creates an item" do
    io = double :io
    expect(io).to receive(:print)
      .with("Name: ")
        .ordered
    expect(io).to receive(:gets)
      .and_return("Enchilada")
        .ordered
    expect(io).to receive(:print)
      .with("Price: ")
        .ordered
    expect(io).to receive(:gets)
      .and_return("7.99")
        .ordered
    expect(io).to receive(:print)
      .with("Quantity: ")
        .ordered
    expect(io).to receive(:gets)
      .and_return("60")
        .ordered
    expect(io).to receive(:puts)
      .with("Item created!")
        .ordered

        
    app = create_app(io)
    app.create_item
    
    new_item = @item_repository.all.last
    expect(new_item.id).to eq 8
    expect(new_item.name).to eq "Enchilada"
    expect(new_item.unit_price).to eq 7.99
    expect(new_item.quantity).to eq 60
  end

  it "prints all orders" do
    io = double :io
    expect(io).to receive(:puts)
      .with('All orders:')
        .ordered
    expect(io).to receive(:puts)
      .with('Sam - 2023-03-31')
        .ordered
    expect(io).to receive(:puts)
      .with('Bob - 2023-02-28')
        .ordered
    expect(io).to receive(:puts)
      .with('Jim - 2023-04-22')
        .ordered

    app = create_app(io)
    app.print_orders
  end

  it "prints orders by item" do
    io = double :io
    expect(io).to receive(:puts)
      .with("What item do you want to see the orders for?")
        .ordered
    expect(io).to receive(:gets)
      .and_return('1')
        .ordered
    expect(io).to receive(:puts)
      .with('Sam - 2023-03-31')
        .ordered
    expect(io).to receive(:puts)
      .with('Jim - 2023-04-22')
        .ordered

    app = create_app(io)
    app.print_orders_by_item
  end

  it "creates an order" do 
    io = double :io
    expect(io).to receive(:print)
      .with("Name: ")
        .ordered
    expect(io).to receive(:gets)
      .and_return("Jeremy")
        .ordered
    expect(io).to receive(:print)
      .with("Date: ")
        .ordered
    expect(io).to receive(:gets)
      .and_return("2023-05-01")
        .ordered
    expect(io).to receive(:puts)
      .with("Order created!")
        .ordered

    app = create_app(io)
    app.create_order

    created_order = @order_repository.all.last
    expect(created_order.id).to eq 4
    expect(created_order.customer_name).to eq 'Jeremy'
    expect(created_order.date).to eq '2023-05-01'
  end

  xit "loops when the program is run" do
    io = double :io
    expect(io).to receive(:gets).and_return('1').ordered
    expect(io).to receive(:gets).and_return('4').ordered
    expect(io).to receive(:gets).and_return('7').ordered
    expect(io).to receive(:exit).ordered
    app = create_app(io)
    expect(app).to receive(:print_items).ordered
    expect(app).to receive(:print_orders).ordered
    app.run
  end
end
