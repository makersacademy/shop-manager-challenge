require 'item_repository'

def reset_items_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_inventory_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  it "gets all items" do
    repo = ItemRepository.new
    items = repo.all

    expect(items.length).to eq 3

    expect(items[0].id).to eq 1
    expect(items[0].name).to eq 'TV'
    expect(items[0].price).to eq 99.99
    expect(items[0].quantity).to eq 5

    expect(items[1].id).to eq 2
    expect(items[1].name).to eq 'Fridge'
    expect(items[1].price).to eq 80.00
    expect(items[1].quantity).to eq 10
  end

  it "gets a single item" do
    repo = ItemRepository.new
    item = repo.find(1)

    expect(item.id).to eq 1
    expect(item.name).to eq 'TV'
    expect(item.price).to eq 99.99
    expect(item.quantity).to eq 5
  end

  it "creates a single item" do
    repo = ItemRepository.new
    item = Item.new
    item.name = 'Kettle'
    item.price = 10.00
    item.quantity = 13
    repo.create(item)

    all_items = repo.all
    expect(all_items.last.id).to eq 4
    expect(all_items.last.name).to eq 'Kettle'
    expect(all_items.last.price).to eq 10.00
    expect(all_items.last.quantity).to eq 13
  end

  it "deletes a single item" do
    repo = ItemRepository.new
    repo.delete(2)
    items = repo.all
    expect(items.length).to eq 2
    expect(items[0].id).to eq 1
    expect(items[1].id).to eq 3
  end

  it "updates a single item" do
    repo = ItemRepository.new
    item = repo.find(2)
    item.price = 82.00
    item.quantity = 9
    repo.update(item)
    item = repo.find(2)
    expect(item.name).to eq "Fridge"
    expect(item.price).to eq 82.00
    expect(item.quantity).to eq 9
  end

  xit "finds an item and it's related orders" do
    repo = ItemRepository.new
    item = repo.find_with_order(2)
    expect(item.orders.length).to eq 1
    expect(item.first.name).to eq 'TV'
    expect(item.first.price).to eq 99.99
    expect(item.first.quantity).to eq 5
    expect(item.orders.first.customer).to eq 'Rob'
    expect(item.orders.first.date).to eq 'Jan-01-2022'
  end

end