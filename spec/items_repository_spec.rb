require "items_repository"

def reset_items_items_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end
RSpec.describe ItemsRepository do
  before(:each) do 
    reset_items_items_table
  end
  it "Gets all items" do 
    repo = ItemsRepository.new
    items = repo.all

    expect(items.length).to eq  2
    expect(items[0].id).to eq  "1"
    expect(items[0].item_name).to eq  'GOLD NECKLACE'
    expect(items[0].price).to eq  "800"
    expect(items[0].quantity).to eq "19"
    expect(items[1].id).to eq  "2"
    expect(items[1].item_name).to eq  'GOLD PENDANT'
    expect(items[1].price).to eq  "1500"
    expect(items[1].quantity).to eq "12"
  end 
   it "Get a single order" do
    repo = ItemsRepository.new
    items = repo.find(1)

    expect(items.id).to eq  "1"
    expect(items.item_name).to eq  'GOLD NECKLACE'
    expect(items.price).to eq  "800"
    expect(items.quantity).to eq  "19"
  end 

end 

  
    