require "item_repository"

def reset_items_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  it "#all returns all items" do
    repo = ItemRepository.new
    items = repo.all

    expect(items.length).to eq 2
    expect(items[0].id).to eq 1
    expect(items[0].name).to eq 'Bread'
    expect(items[0].unit_price).to eq '1.00'
    expect(items[0].quantity).to eq '20'

    expect(items[1].id).to eq 2
    expect(items[1].name).to eq 'Ham'
    expect(items[1].unit_price).to eq '3.00'
    expect(items[1].quantity).to eq '30'
  end

  it "#find returns a single item" do
    repo = ItemRepository.new
    items = repo.find(1)

    expect(items.id).to eq 1
    expect(items.name).to eq 'Bread'
    expect(items.unit_price).to eq '1.00'
    expect(items.quantity).to eq '20'
  end

  it "#create a new item" do
    repo = ItemRepository.new
    item = Item.new
    item.id = 3
    item.name = 'Jam'
    item.unit_price = '1.50'
    item.quantity = '25'

    repo.create(item)

    expect(repo.all.length).to eq 3
    expect(repo.all.last.name).to eq 'Jam'
  end

  it "#delete an item" do
    repo = ItemRepository.new
    item = repo.find(1)
    repo.delete(item.id)

    expect(repo.all.length).to eq 1
    expect(repo.all.first.id).to eq 2
  end

  it "#update an item" do
    repo = ItemRepository.new
    item = repo.find(1)

    item.name = 'Bagle'
    item.unit_price = '1.50'
    item.quantity = '25'

    repo.update(item)

    updated_item = repo.find(1)
    expect(updated_item.name).to eq 'Bagle'
    expect(updated_item.unit_price).to eq '1.50'
    expect(updated_item.quantity).to eq '25'
  end

end
