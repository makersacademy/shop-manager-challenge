require_relative '../app'

RSpec.describe Application do

  def reset_artists_table
    seed_sql = File.read('spec/seed_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_artists_table
  end

  it 'tests create(item) method and calls sub class' do
    io = double :io
    expect(io).to receive(:puts).with 'Please enter name of new item'
    expect(io).to receive(:gets).and_return 'irn bru'
    expect(io).to receive(:puts).with 'Please enter unit price'
    expect(io).to receive(:gets).and_return '1'
    expect(io).to receive(:puts).with 'Please enter quantity'
    expect(io).to receive(:gets).and_return '10'
    expect(io).to receive(:puts).with 'Please enter order number'
    expect(io).to receive(:gets).and_return '1'
    expect(io).to receive(:puts).with 'irn bru - Unit price: 1 - Quantity: 10 - added to items'
    run_app = Application.new('shop_manager_test', io, 'lib/item_repository', 'lib/order_repository')
    run_app.create('item')
    repo = ItemRepository.new
    items = repo.all
    expect(items.length).to eq 4
    expect(items[3].item_name).to eq 'irn bru'
    expect(items[3].price).to eq '1'
    expect(items[3].quantity).to eq '10'
    expect(items[3].order_id).to eq '1'
  end

  it 'tests create(new_order) method and call sub class' do
    io = double :io
    expect(io).to receive(:puts).with 'Please enter customer_name for new order'
    expect(io).to receive(:gets).and_return 'Bob'
    expect(io).to receive(:puts).with 'Please enter order date as month'
    expect(io).to receive(:gets).and_return 'sept'
    expect(io).to receive(:puts).with 'Bob - order created: sept'
    run_app = Application.new('shop_manager_test', io, 'lib/item_repository', 'lib/order_repository')
    run_app.create('order')
    repo = OrderRepository.new
    orders = repo.all
    expect(orders.length).to eq 3
    expect(orders[2].customer_name).to eq 'Bob'
    expect(orders[2].date).to eq 'sept'
  end
 
end
