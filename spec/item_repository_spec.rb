require "item_repository"
require "pg"

def reset_shop_manager
  seed_sql = File.read('spec/shop_manager_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_shop_manager
  end

  it "gets all items" do
    repo = ItemRepository.new

    items = repo.all

    expect(items.length).to eq(3)

    expect(items[0].id).to eq('1') 
    expect(items[0].title).to eq('Sweater') 
    expect(items[0].price).to eq('30')
    expect(items[0].stock).to eq('5') 
    expect(items[0].order_id).to eq('1') 

    expect(items[1].id).to eq('2')
    expect(items[1].title).to eq('Jeans') 
    expect(items[1].price).to eq('40') 
    expect(items[1].stock).to eq('10') 
    expect(items[1].order_id).to eq('2') 

    expect(items[2].id).to eq('3') 
    expect(items[2].title).to eq('Skirt') 
    expect(items[2].price).to eq('20') 
    expect(items[2].stock).to eq('7') 
    expect(items[2].order_id).to eq('3') 
  end

  it "gets a single item" do
    repo = ItemRepository.new

    item = repo.find(1)

    expect(item.id).to eq('1')
    expect(item.title).to eq('Sweater') 
    expect(item.price).to eq('30') 
    expect(item.stock).to eq('5') 
    expect(item.order_id).to eq('1') 
  end

  it "creates a new item" do
    repo = ItemRepository.new

    new_item = Item.new

    new_item.title = 'Dress'
    new_item.price = '50'
    new_item.stock = '20'
    new_item.order_id = '3'

    repo.create(new_item) 

    items = repo.all
    last_item = items.last
    expect(last_item.title).to eq('Dress')
    expect(last_item.price).to eq('50')
    expect(last_item.stock).to eq('20') 
    expect(last_item.order_id).to eq('3')
  end

  it "deletes an item" do
    repo = ItemRepository.new
    id_to_delete = 1

    repo.delete(id_to_delete)

    all_items = repo.all

    expect(all_items.length).to eq(2)
    expect(all_items.first.id).to eq('2')
  end

  it "updates an item" do
    repo = ItemRepository.new

    item = repo.find(1)
    item.title = 'Shirt'
    item.price = '25'
    item.stock = '15'
    item.order_id = '1'

    repo.update(item)

    updated_item = repo.find(1)
    expect(updated_item.title).to eq('Shirt')
    expect(updated_item.price).to eq('25')
    expect(updated_item.stock).to eq('15') 
    expect(updated_item.order_id).to eq('1') 
  end

end