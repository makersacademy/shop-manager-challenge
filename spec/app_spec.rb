require_relative '../app'

describe Application do 

  def reset_tables
    seed_sql = File.read('spec/shop_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_tables
  end

  it 'Should return all shop items in a list when 1 is selected by user' do
    io = double :io
    order_repo = double :order
    item_repo = ItemRepository.new
    expect(io).to receive(:puts).with("What do you want to do?").ordered
    expect(io).to receive(:puts).with("1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("1").ordered
    expect(io).to receive(:puts).with("#1 - Candlestick - Unit price: 1.99 - Quantity: 10").ordered
    expect(io).to receive(:puts).with("#2 - Lead-Pipe - Unit price: 4.45 - Quantity: 3").ordered
    expect(io).to receive(:puts).with("#3 - Gun - Unit price: 12.95 - Quantity: 1").ordered
    app = Application.new('shop_manager_test', io, item_repo, order_repo)
    app.run
  end

  it 'Should return all shop orders in a list when 3 is selected by user' do
    io = double :io
    order_repo = OrderRepository.new
    item_repo = double :item
    expect(io).to receive(:puts).with("What do you want to do?").ordered
    expect(io).to receive(:puts).with("1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order").ordered
    expect(io).to receive(:gets).and_return("3").ordered
    expect(io).to receive(:puts).with("#1 - Customer name: Professor Plum - Date placed: 2023-12-12").ordered
    expect(io).to receive(:puts).with("#2 - Customer name: Colonel Mustard - Date placed: 2023-12-12").ordered
    expect(io).to receive(:puts).with("#3 - Customer name: Miss Scarlet - Date placed: 2023-03-09").ordered
    expect(io).to receive(:puts).with("#4 - Customer name: Reverend Green - Date placed: 2023-12-12").ordered
    expect(io).to receive(:puts).with("#5 - Customer name: Mrs Peacock - Date placed: 2023-12-12").ordered
    expect(io).to receive(:puts).with("#6 - Customer name: Chef White - Date placed: 2023-10-10").ordered
    expect(io).to receive(:puts).with("#7 - Customer name: Miss Peach - Date placed: 2023-10-06").ordered
    expect(io).to receive(:puts).with("#8 - Customer name: Madame Rose - Date placed: 2023-07-11").ordered
    expect(io).to receive(:puts).with("#9 - Customer name: Lady Lavender - Date placed: 2023-08-12").ordered
    app = Application.new('shop_manager_test', io, item_repo, order_repo)
    app.run
  end
end
