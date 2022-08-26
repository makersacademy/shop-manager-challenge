require 'item_repository'

def reset_items_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'orders_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  it "returns list of all shop items" do
    repository = ItemRepository.new
    items = repository.all

    expect(items.length).to eq 3

    expect(items[0].id).to eq 1
    expect(items[0].name).to eq 'iPhone'
    expect(items[0].unit_price).to eq 20
    expect(items[0].quantity).to eq 5

    expect(items[1].id).to eq 2
    expect(items[1].name).to eq 'Tv'
    expect(items[1].unit_price).to eq 50
    expect(items[1].quantity).to eq 10

    expect(items[2].id).to eq 3
    expect(items[2].name).to eq 'Apple'
    expect(items[2].unit_price).to eq 10
    expect(items[2].quantity).to eq 8
  end

  it "creates a new item record" do
    repository = ItemRepository.new
    item = double :item, name: 'Chicken', unit_price: '10', quantity: 20

    repository.create(item)
    all_items = repository.all
    
    last = all_items.last
    expect(last.name).to eq 'Chicken'
    expect(last.unit_price).to eq 10
    expect(last.quantity).to eq 20
  end

  it "find a specific item record" do
    repository = ItemRepository.new
    order = repository.find_orders_by_item_id(3)

    expect(order.items.length).to eq 2
    expect(order.customer_name).to eq "Penzema"
    expect(order.date).to eq "2022-12-04"
  end
end