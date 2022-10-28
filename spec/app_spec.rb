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
    expect(io).to receive(:puts).with ("5 = view orders by item")
    expect(io).to receive(:gets).and_return('1')
    expect(io).to receive(:puts).with ("Here is the list of current inventory:")
    expect(io).to receive(:puts).with("1 - Sherbet Lemons - Unit price: 1 - Quantity: 500")
    expect(io).to receive(:puts).with("2 - Starmix - Unit price: 3 - Quantity: 250")
    expect(io).to receive(:puts).with("3 - Candy Apple - Unit price: 5 - Quantity: 20")
    expect(io).to receive(:puts).with("4 - Foam Bananas - Unit price: 1 - Quantity: 40")
    expect(io).to receive(:puts).with("5 - Lollipops - Unit price: 2 - Quantity: 650")
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
    expect(io).to receive(:puts).with ("5 = view orders by item")
    expect(io).to receive(:gets).and_return('3')
    expect(io).to receive(:puts).with ("Here is a list of all the orders:")
    expect(io).to receive(:puts).with ("1 - John Smith - 04/01/2022")
    expect(io).to receive(:puts).with ("2 - Jane Bower - 06/01/2022")
    expect(io).to receive(:puts).with ("3 - Sylvia Hanratty - 14/11/2022")
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
    expect(io).to receive(:puts).with ("5 = view orders by item")
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
    expect(io).to receive(:puts).with ("5 = view orders by item")
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

  it 'returns a list of orders by item number' do
    io = double :io
    expect(io).to receive(:puts).with('Welcome to the sweet shop management program!')
    expect(io).to receive(:puts).with ("What do you want to do?")
    expect(io).to receive(:puts).with ("1 = list all shop items")
    expect(io).to receive(:puts).with ("2 = create a new item")
    expect(io).to receive(:puts).with ("3 = list all orders")
    expect(io).to receive(:puts).with ("4 = create a new order")
    expect(io).to receive(:puts).with ("5 = view orders by item")
    expect(io).to receive(:gets).and_return('5')
    expect(io).to receive(:puts).with('Please enter an item number (1-5)')
    expect(io).to receive(:gets).and_return('3')
    expect(io).to receive(:puts).with ("Thank you for using the sweet shop management program!")
    application = Application.new('shop_challenge_test', io, ItemRepository.new, OrderRepository.new)
    application.run
  end
end
