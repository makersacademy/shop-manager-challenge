require_relative '../lib/item_repository'

def reset_items_orders_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do

  before(:each) do 
    reset_items_orders_table
  end

  it "returns all items" do
    repo = ItemRepository.new

    items = repo.all
    
    expect(items.length).to eq 3
    expect(items[0].id).to eq '1'
    expect(items[0].product).to eq 'Apple'
    expect(items[0].price).to eq '1'
    expect(items[0].quantity).to eq '100'
    expect(items[1].id).to eq '2'
    expect(items[1].product).to eq 'Banana'
    expect(items[1].price).to eq '2'
    expect(items[1].quantity).to eq '50'
  end

  it "adds a new item" do
    repo = ItemRepository.new

    item = Item.new
    item.product = 'Damsen'
    item.price = 5
    item.quantity = 10
    repo.add(item)
    
    items = repo.all
    
    expect(items.length).to eq 4
    expect(items[-1].id).to eq '4'
    expect(items[-1].product).to eq 'Damsen'
    expect(items[-1].price).to eq '5'
    expect(items[-1].quantity).to eq '10'
  end
end