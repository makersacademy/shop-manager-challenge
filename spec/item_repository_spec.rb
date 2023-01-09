require 'item_repository'
require 'item'

describe ItemRepository do

  def reset_shop_tables
    seed_sql = File.read('spec/shop_manager_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_shop_tables
  end

  it 'gets all items' do
    repo = ItemRepository.new
    current_items = repo.all
    expect(current_items.length).to eq 2
    expect(current_items[0].item_name).to eq 'Fanta'
    expect(current_items[0].unit_price).to eq 1
    expect(current_items[0].quantity).to eq  300
    expect(current_items[1].item_name).to eq 'Coke'
    expect(current_items[1].unit_price).to eq  2
    expect(current_items[1].quantity).to eq 400
  end

  it 'gets a single item' do
    repo = ItemRepository.new
    single_item = repo.find(1)
    expect(single_item[0].item_name).to eq 'Fanta'
    expect(single_item[0].unit_price).to eq 1
    expect(single_item[0].quantity).to eq 300
  end

  it 'add single item' do
    repo = ItemRepository.new
    tango = Item.new
    tango.item_name = 'Tango'
    tango.unit_price = 3
    tango.quantity = 500
    repo.create(tango)
    new_item = repo.find(3)
    expect(new_item[0].item_name).to eq 'Tango'
    expect(new_item[0].unit_price).to eq 3
    expect(new_item[0].quantity).to eq 500
  end




end





