require 'item_repo'

def reset_tables
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_tables
  end

  it "gets all items" do
    repo = ItemRepository.new
    items = repo.all
    
    expect(items.length).to eq 5
    
    expect(items[0].id).to eq '1'
    expect(items[0].name).to eq 'Hoover'
    expect(items[0].unit_price).to eq '100'
    expect(items[0].qty).to eq'20'
    
    expect(items[1].id).to eq '2'
    expect(items[1].name).to eq 'Washing Machine'
    expect(items[1].unit_price).to eq '400'
    expect(items[1].qty).to eq'30'  
  end

end