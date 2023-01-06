require_relative "../lib/item_repository"

def reset_items_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  it "gets all items" do
    repo = ItemRepository.new

    items = repo.all

    expect(items.length).to eq 2

    expect(items[0].id).to eq '1'
    expect(items[0].name).to eq 'Super Shark Vacuum Cleaner'
    expect(items[0].price).to eq '99'
    expect(items[0].quantity).to eq '30'

    expect(items[1].id).to eq '2' # =>  2
    expect(items[1].name).to eq 'Makerspresso Coffee Machine'
    expect(items[1].price).to eq '70'
    expect(items[1].quantity).to eq '15'
  end

  it "gets a single item" do
    repo = ItemRepository.new

    item = repo.find(1)

    expect(item.id).to eq "1"
    expect(item.name).to eq "Super Shark Vacuum Cleaner"
    expect(item.price).to eq "99"
    expect(item.quantity).to eq "30"
  end

  it "creates an item entry" do
    repo = ItemRepository.new

    item = Item.new
    item.name = 'Bosch Washing Machine'
    item.price = '300'
    item.quantity = '20'

    repo.create(item)

    items = repo.all
    last_item = items.last
    expect(last_item.name).to eq 'Bosch Washing Machine'
    expect(last_item.price).to eq '300'
    expect(last_item.quantity).to eq '20'
  end

  it "updates an item entry" do
    repo = ItemRepository.new

    item = repo.find(2)
    item.name = 'Makerspresso Coffee Machine'
    item.price = '85'
    item.quantity = '30'

    repo.update(item)

    updated_item = repo.find(2)

    expect(updated_item.id).to eq '2'
    expect(updated_item.name).to eq 'Makerspresso Coffee Machine'
    expect(updated_item.price).to eq '85'
    expect(updated_item.quantity).to eq '30'
  end

  it "deletes an item" do
    repo = ItemRepository.new

    delete_item = repo.delete('1')
    items = repo.all

    expect(items.length).to eq 1

    expect(items[0].id).to eq "2"
    expect(items[0].name).to eq "Makerspresso Coffee Machine"
    expect(items[0].price).to eq "70"
    expect(items[0].quantity).to eq "15"
  end
end