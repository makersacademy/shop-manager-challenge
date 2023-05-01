require_relative '../app'

describe Application do 

  def reset_items_table
    seed_sql = File.read('spec/item_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_items_table
  end

  it 'Should return all shop items in a list when 1 is selected by user' do
    io = double :io
    order_repo = double :order
    item_repo = ItemRepository.new
    expect(io).to receive(:puts).with("What do you want to do?").ordered
    expect(io).to receive(:puts).with("1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("1")
    expect(io).to receive(:puts).with("#1 - Candlestick - Unit price: 1.99 - Quantity: 10")
    expect(io).to receive(:puts).with("#2 - Lead-Pipe - Unit price: 4.45 - Quantity: 3")
    expect(io).to receive(:puts).with("#3 - Gun - Unit price: 12.95 - Quantity: 1")
    app = Application.new('shop_manager_test', io, item_repo, order_repo)
    app.run
  end
end
