require_relative '../lib/item_repo'

RSpec.describe ItemRepository do
  def reset_orders_table
    seed_sql = File.read('spec/seed_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_orders_table
  end

  it 'shows all items' do
    repo = ItemRepository.new
    items = repo.all
    expect(items[0].id).to eq '1'
    expect(items[0].item_name).to eq 'cheese'
    expect(items[0].price).to eq '2'
    expect(items[0].quantity).to eq '5'
    expect(items[0].order_id).to eq '1'
  end
 
  it 'shows all items' do  
    repo = ItemRepository.new
    items = repo.all
    expect(items[1].id).to eq '2'
    expect(items[1].item_name).to eq 'hot crossed buns'
    expect(items[1].price).to eq '3'
    expect(items[1].quantity).to eq '10'
    expect(items[1].order_id).to eq '1'
  end
    
  it 'shows all items' do   
    repo = ItemRepository.new
    items = repo.all
    expect(items[2].id).to eq '3'
    expect(items[2].item_name).to eq 'sausage'
    expect(items[2].price).to eq '1'
    expect(items[2].quantity).to eq '5'
    expect(items[2].order_id).to eq '2' 
  end

  it 'creates a new item' do
    repo = ItemRepository.new
    item = Item.new
    item.item_name = 'chips' 
    item.price = '2' 
    item.quantity = '4' 
    item.order_id = '2'

    repo.create(item)

    items = repo.all
    expect(items.length).to eq 4
    expect(items[3].item_name).to eq 'chips' 
    expect(items[3].price).to eq '2' 
    expect(items[3].quantity).to eq '4' 
    expect(items[3].order_id).to eq '2'
  end

end
