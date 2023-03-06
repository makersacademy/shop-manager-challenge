require 'item_repository'


RSpec.describe ItemRepository do 

  def reset_items_table
    seed_sql = File.read('spec/seeds_items_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_items_table
  end

  it 'returns a list of items' do 
    repo = ItemRepository.new

    items = repo.all

    expect(items.length).to eq 4

    expect(items[0].id).to eq 1
    expect(items[0].name).to eq 'Mascara'
    expect(items[0].unit_price).to eq  9
    expect(items[0].item_quantity).to eq 30


    expect(items[1].id).to eq  2
    expect(items[1].name).to eq 'Foundation'
    expect(items[1].unit_price).to eq 42
    expect(items[1].item_quantity).to eq 40
  end 


  it 'returns a single item' do 
    repo = ItemRepository.new

    item = repo.find(1)

    expect(item.id).to eq  1
    expect(item.name).to eq 'Mascara'
    expect(item.unit_price).to eq 9
    expect(item.item_quantity).to eq  30
  end 

end
