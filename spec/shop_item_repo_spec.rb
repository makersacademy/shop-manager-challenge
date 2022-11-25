require 'shop_item_repository'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_challenge_test' })
  connection.exec(seed_sql)
end

describe ShopItemRepository do
  before(:each) do 
    reset_tables
  end

  it 'returns all shop items' do 
    repo = ShopItemRepository.new

    shop_items = repo.all

    expect(shop_items.length).to eq(5)

    expect(shop_items[0].id).to eq('1')
    expect(shop_items[0].name).to eq('sandwich')
    expect(shop_items[0].unit_price).to eq('2.99')
    expect(shop_items[0].quantity).to eq('10')

    expect(shop_items[1].id).to eq('2') 
    expect(shop_items[1].name).to eq('bananas') 
    expect(shop_items[1].unit_price).to eq('1.99')
    expect(shop_items[1].quantity).to eq('15')
  end

  it 'creates a new shop item' do 
    repo = ShopItemRepository.new 

    shop_item = ShopItem.new
    shop_item.name = 'skittles'
    shop_item.unit_price = 0.99
    shop_item.quantity = 10

    repo.create(shop_item)

    shop_items = repo.all

    expect(shop_items.last.name).to eq('skittles')
  end
end