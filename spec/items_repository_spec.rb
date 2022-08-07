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
   it "Get a single item" do
    repo = ItemsRepository.new
    items = repo.find(1)

    expect(items.id).to eq  "1"
    expect(items.item_name).to eq  'GOLD NECKLACE'
    expect(items.price).to eq  "800"
    expect(items.quantity).to eq  "19"
  end
   it "create a single item" do 
    repo = ItemsRepository.new
    item = Item.new
    item.item_name =  'rings_new'
    item.price =  34
    item.quantity =  6
    repo.create(item)
    items = repo.all

    expect(items[2].id).to eq "3"
    expect(items[2].item_name).to eq  'rings_new'
    expect(items[2].price).to eq  "34"
    expect(items[2].quantity).to eq "6"
   end
    it "update an item" do 
    repo = ItemsRepository.new
    item = repo.find(1)
    item.item_name = 'rubies_new'
    repo.update(item)
    items = repo.all

    expect(items[1].id).to eql "1"
    expect(items[1].item_name).to eql  'rubies_new'
    expect(items[1].price).to eql"800"
    expect(items[1].quantity).to eql "19"
   end
    it "delete an item" do 
    repo = ItemsRepository.new
    item = repo.find(1)

    repo.delete(item)

    items = repo.all
    expect(items.length).to eq 1
   end 

end 

  
    