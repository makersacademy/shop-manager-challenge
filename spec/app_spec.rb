require_relative '../app'

RSpec.describe Application do

  def reset_tables
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_tables
  end

  it 'shows the shop management system' do
    database_name = 'shop_manager_test'
    io = double(:io)
    order_repository = OrderRepository.new
    item_repository = ItemRepository.new
    app = Application.new(database_name, io, item_repository, order_repository)
    expect(io).to receive(:puts).with('Welcome to the shop management program!')
    expect(io).to receive(:puts).with('What do you want to do?')
    expect(io).to receive(:puts).with('1 - List all items')
    expect(io).to receive(:puts).with('2 - Create a new item')
    expect(io).to receive(:puts).with('3 - List all orders')
    expect(io).to receive(:puts).with('4 - Create a new order')
    expect(io).to receive(:puts).with('Enter your choice:')
    app.run
    
  end
end
