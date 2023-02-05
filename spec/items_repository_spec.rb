require 'item_repository'

def reset_items_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  it 'returns all the items' do
    repo = ItemRepository.new
    item = repo.all
    expect(item.length).to eq 2 # =>  2
    expect(item.first.id).to eq '1' # =>  1
    expect(item.first.name).to eq 'Cheese' # =>  'Cheese'
    expect(item.first.quantity).to eq '8' # =>  '8'
  end

  it 'returns item with id = 2' do
    repo = ItemRepository.new
    item = repo.find(2)
    expect(item.name).to eq 'Cake' #=> 'Cake'
    expect(item.quantity).to eq '5' #=> '5'
  end

  it 'adds new item to the list of items' do
    repo = ItemRepository.new
    new_item = Item.new
    new_item.id = '3'
    new_item.name = 'Jelly'
    new_item.quantity = '4'
    new_item.price = '3'
    repo.create(new_item)
    all_items = repo.all
    expect(all_items).to include(
      have_attributes(
        id: '3',
        name: new_item.name,
        quantity: '4',
        price: '3'
      )
    )
  end
end