require_relative '../app'

RSpec.describe Application do

  def reset_shop_table
    seed_sql = File.read('spec/seeds_shop.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_challenge_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_shop_table
  end

  it 'returns a list of all shop items' do
    io = double :io
    expect(io).to receive(:puts).with('Welcome to the shop management program!')
    expect(io).to receive(:puts).with ("What do you want to do?")
    expect(io).to receive(:puts).with ("1 = list all shop items")
    expect(io).to receive(:puts).with ("2 = create a new item")
    expect(io).to receive(:puts).with ("3 = list all orders")
    expect(io).to receive(:puts).with ("4 = create a new order")
    expect(io).to receive(:gets).and_return('1')
    application = Application.new('shop_challenge_test', io, ItemRepository.new)
    application.run
  end

  it 'creates a new item' do
    io = double :io
    expect(io).to receive(:puts).with('Welcome to the shop management program!')
    expect(io).to receive(:puts).with ("What do you want to do?")
    expect(io).to receive(:puts).with ("1 = list all shop items")
    expect(io).to receive(:puts).with ("2 = create a new item")
    expect(io).to receive(:puts).with ("3 = list all orders")
    expect(io).to receive(:puts).with ("4 = create a new order")
    expect(io).to receive(:gets).and_return('2')
    expect(io).to receive(:puts).with('Please enter item name')
    expect(io).to receive(:gets).and_return('Chocolate')
    expect(io).to receive(:puts).with('Please enter item price')
    expect(io).to receive(:gets).and_return('14')
    expect(io).to receive(:puts).with('Please enter item quantity')
    expect(io).to receive(:gets).and_return('10')
    expect(io).to receive(:puts).with('Item created')
    application = Application.new('shop_challenge_test', io, ItemRepository.new)
    application.run
  end
end
