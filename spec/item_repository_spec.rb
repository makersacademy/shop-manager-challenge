require 'item_repository'

describe ItemRepository do

  def reset_items_table
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_items_table
  end

  it 'returns all items ' do 
    repo = ItemRepository.new

    items = repo.all 
    expect(items.length).to eq 4
    expect(items.first.id).to eq '1' 
    expect(items.first.name).to eq 'Notebook'
    expect(items.first.price).to eq '1'
    expect(items.first.quantity).to eq "10"
  end 


  it 'returns a single item' do 
    repo = ItemRepository.new

    item = repo.find(1)
    expect(item.name).to eq 'Notebook'
    expect(item.price).to eq '1' 
    expect(item.quantity).to eq '10'
  end 

  it 'returns a single item' do 
    repo = ItemRepository.new

    item = repo.find(3)
    expect(item.name).to eq 'Trousers'
    expect(item.price).to eq '10' 
    expect(item.quantity).to eq '15'
  end 

  it 'creates a new item' do 
    repo = ItemRepository.new

    item = Item.new
    item.name = 'Tank Top'
    item.price = '7' 
    item.quantity = '13'

    repo.create(item)

    items = repo.all 

    last_item = items.last 
    expect(last_item.name).to eq 'Tank Top'
    expect(last_item.price).to eq '7' 
    expect(last_item.quantity).to eq '13'
  end 
end 