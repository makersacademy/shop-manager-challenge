require "item_repository"
require "item"

def reset_items_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end 

RSpec.describe ItemRepository do 
  before(:each) do 
  reset_items_table
  end

  it "returns all items in table" do 
    repo = ItemRepository.new 
    items = repo.all

    expect(items.length).to eq 3

    expect(items[0].name).to eq 'shirt'
    expect(items[0].price).to eq 10 
    expect(items[0].quantity).to eq 20

    expect(items[1].name).to eq 'trouser'
    expect(items[1].price).to eq 5 
    expect(items[1].quantity).to eq 5

    expect(items[2].name).to eq 'tie'
    expect(items[2].price).to eq 2
    expect(items[2].quantity).to eq 10
  end 

  it "creates a new item" do 
    repo = ItemRepository.new 

    item = Item.new

    item.name = "blazer"
    item.price = 50
    item.quantity = 100

    repo.create(item)
    items = repo.all 


    expect(item.name).to eq "blazer"
    expect(item.price).to eq 50
    expect(item.quantity).to eq 100
  end 
end 