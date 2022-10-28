require_relative '../lib/item_repository'

def reset_shop_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_shop_table
  end

  it 'returns all items in stock' do
    repo = ItemRepository.new
    stock = repo.all
    expect(stock.length).to eq 8
    expect(stock[0].name).to eq 'Socks'
    expect(stock[2].price).to eq '$12.00'
    expect(stock[5].quantity).to eq '90'
  end

  it 'returns item with ID 2' do
    repo = ItemRepository.new
    item = repo.find(2)
    expect(item.name).to eq 'Trousers'
    expect(item.price).to eq '$11.00'
    expect(item.quantity).to eq '75'
  end

  it 'creates a new item' do
    repo = ItemRepository.new
    new_item = Item.new
    new_item.name = 'Sunglasses'
    new_item.price = '$5.25'
    new_item.quantity = '35'
    repo.create(new_item)
    stock = repo.all
    expect(stock.length).to eq 9
    expect(stock.last.name).to eq 'Sunglasses'
    expect(stock.last.price).to eq '$5.25'
    expect(stock.last.quantity).to eq '35'
  end

  it 'returns orders placed with item ID 7' do
    repo = ItemRepository.new
    item = repo.find_orders_with_item('7')
    expect(item.name).to eq 'Scarf'
    expect(item.orders.length).to eq 2
    expect(item.orders[0].customer_name).to eq 'Bon'
    expect(item.orders[1].date).to eq '2022-08-27'
  end
end
