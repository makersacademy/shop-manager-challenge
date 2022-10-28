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
    expect(io).to receive(:puts).with('Welcome to the sweet shop management program!')
    expect(io).to receive(:puts).with ("What do you want to do?")
    expect(io).to receive(:puts).with ("1 = list all shop items")
    expect(io).to receive(:puts).with ("2 = create a new item")
    expect(io).to receive(:puts).with ("3 = list all orders")
    expect(io).to receive(:puts).with ("4 = create a new order")
    expect(io).to receive(:gets).and_return('1')
    expect(io).to receive(:puts).with ("Here is the list of current inventory:")
    expect(io).to receive(:puts).with ("Thank you for using the sweet shop management program!")
    application = Application.new('shop_challenge_test', io, ItemRepository.new, OrderRepository.new)
    application.run
  end

  it 'returns a list of all shop orders' do
    io = double :io
    expect(io).to receive(:puts).with('Welcome to the sweet shop management program!')
    expect(io).to receive(:puts).with ("What do you want to do?")
    expect(io).to receive(:puts).with ("1 = list all shop items")
    expect(io).to receive(:puts).with ("2 = create a new item")
    expect(io).to receive(:puts).with ("3 = list all orders")
    expect(io).to receive(:puts).with ("4 = create a new order")
    expect(io).to receive(:gets).and_return('3')
    expect(io).to receive(:puts).with ("Here is a list of all the orders:")
    expect(io).to receive(:puts).with ("Thank you for using the sweet shop management program!")
    application = Application.new('shop_challenge_test', io, ItemRepository.new, OrderRepository.new)
    application.run
  end

  it 'creates a new item' do
    io = double :io
    expect(io).to receive(:puts).with('Welcome to the sweet shop management program!')
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
    expect(io).to receive(:puts).with ("Thank you for using the sweet shop management program!")
    application = Application.new('shop_challenge_test', io, ItemRepository.new, OrderRepository.new)
    application.run
  end

  it 'creates a new order' do
    io = double :io
    expect(io).to receive(:puts).with('Welcome to the sweet shop management program!')
    expect(io).to receive(:puts).with ("What do you want to do?")
    expect(io).to receive(:puts).with ("1 = list all shop items")
    expect(io).to receive(:puts).with ("2 = create a new item")
    expect(io).to receive(:puts).with ("3 = list all orders")
    expect(io).to receive(:puts).with ("4 = create a new order")
    expect(io).to receive(:gets).and_return('4')
    expect(io).to receive(:puts).with('Please enter customer name')
    expect(io).to receive(:gets).and_return('Sadie Long')
    expect(io).to receive(:puts).with('Please enter an order date')
    expect(io).to receive(:gets).and_return('14/07/2022')
    expect(io).to receive(:puts).with('Order created')
    expect(io).to receive(:puts).with ("Thank you for using the sweet shop management program!")
    application = Application.new('shop_challenge_test', io, ItemRepository.new, OrderRepository.new)
    application.run
  end
end
