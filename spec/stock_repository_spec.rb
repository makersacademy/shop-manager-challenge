require 'stock_repository'

describe StockRepository do

  def reset_stock_table
    seed_sql = File.read('spec/seeds_stocks.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_stock_table
  end

  it 'gets all the stock' do

    repo = StockRepository.new

    stock = repo.all

    expect(stock.length).to eq 2

    expect(stock[0].id).to eq '1'
    expect(stock[0].item).to eq 'item1'
    expect(stock[0].unit_price).to eq '1.01'
    expect(stock[0].quantity).to eq '1'

    expect(stock[1].id).to eq '2'
    expect(stock[1].item).to eq 'item2'
    expect(stock[1].unit_price).to eq '2.00'
    expect(stock[1].quantity).to eq '2'
  end

    # 2
  it 'gets a single stock' do

    repo = StockRepository.new

    stock = repo.find(1)

    expect(stock.id).to eq '1'
    expect(stock.item).to eq 'item1'
    expect(stock.unit_price).to eq '1.01'
    expect(stock.quantity).to eq '1'

    stock = repo.find(2)

    expect(stock.id).to eq '2'
    expect(stock.item).to eq 'item2'
    expect(stock.unit_price).to eq '2.00'
    expect(stock.quantity).to eq '2'
  end
    # 3
  it 'create a new object' do

    repo = StockRepository.new
    stock = Stock.new

    stock.id = '3'
    stock.item = 'item3'
    stock.unit_price = '3.00'
    stock.quantity = '3'

    repo.create(stock)

    stocks = repo.all

    expect(stocks).to include(
      have_attributes(
        id: stock.id,
        item: stock.item,
        unit_price: stock.unit_price,
        quantity: stock.quantity
        )
      ) # => returns an array including the new object
  end

  it 'deletes all objects' do

    repo = StockRepository.new
    repo.delete(1)
    repo.delete(2)
    stock = repo.all
    expect(stock.length).to eq 0

  end

  it 'deletes one object' do

    repo = StockRepository.new
    repo.delete(1)
    stock = repo.all
    expect(stock.length).to eq 1

    expect(stock[0].id).to eq '2'
    expect(stock[0].item).to eq 'item2'
    expect(stock[0].unit_price).to eq '2.00'
    expect(stock[0].quantity).to eq '2'
  end

  it 'updates an existing entry' do

    repo = StockRepository.new

    stock = repo.find(2)

    expect(stock.id).to eq '2'
    expect(stock.item).to eq 'item2'
    expect(stock.unit_price).to eq '2.00'
    expect(stock.quantity).to eq '2'

    repo.update(2)

    stock = repo.find(2)

    expect(stock.id).to eq '2'
    expect(stock.item).to eq 'new_item2'
    expect(stock.unit_price).to eq '2.00'
    expect(stock.quantity).to eq '2'
  end
end
