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
    ItemRepository.new,
    OrderRepository.new
  )
end

RSpec.describe Application do
  before(:each) do 
    reset_tables
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

    app = create_app(io)
    app.print_menu
  end

  xit "actions on user selection" do
    io = double :io
    app = create_app(io)
    expect(app).to receive(:print_items)
    app.do_selection(1)
  end
end