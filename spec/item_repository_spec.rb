require 'item_repository'

RSpec.describe ItemRepository do

  def reset_items_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_items_orders_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_items_table
  end

  # (your tests will go here).

  it "returns a list of all the items" do

    repo = ItemRepository.new
    items = repo.all
    expect(items.length).to eq 4

    expect(items[0].id).to eq '1'
    expect(items[0].name).to eq 'Item 1'
    expect(items[0].price).to eq '12.0000'
    expect(items[0].quantity).to eq '5'

  end

  it "creates a new item" do
    repo = ItemRepository.new

    item = Item.new
    item.name = 'Item 5'
    item.price = 19.91
    item.quantity = 1
    
    repo.create(item)
    
    all_items = repo.all
    
    new_item = all_items.last
    
    expect(new_item.id).to eq '5'
    expect(new_item.name).to eq 'Item 5'
    expect(new_item.price).to eq '19.9100'
    expect(new_item.quantity).to eq '1'
  end

  it "find first item related to order 3" do

    repo = ItemRepository.new

    items = repo.find_by_order(3)

    expect(items[0]['id']).to eq '1'
    expect(items[0]['name']).to eq 'Item 1'
    expect(items[0]['price']).to eq '12.0000'
    expect(items[0]['quantity']).to eq '5'
  end

  it "find second item related to order 3" do

    repo = ItemRepository.new

    items = repo.find_by_order(3)

    expect(items[1]['id']).to eq '2'
    expect(items[1]['name']).to eq 'Item 2'
    expect(items[1]['price']).to eq '4.5000'
    expect(items[1]['quantity']).to eq '7'
  end

end