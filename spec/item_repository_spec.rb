require "item_repository"

def reset_items_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop' })
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

end

# # 3 
# # Create a new item
# repo = ItemRepository.new
# item = Item.new
# item.id # =>  3
# item.name # =>  'Jam'
# item.unit_price # =>  '1.50'
# item.quantity # =>  '25'

# repo.create(item)

# item.length # =>  3
# repo.all.last.name # => 'Jam'

# # 4
# # Delete an item
# repo = ItemRepository.new
# item = repo.find(1)
# repo.delete(item.id)

# repo.all # => 1
# repo.all.first.id # => 2

# # 5
# # Update an item 
# repo = ItemRepository.new
# item = repo.find(1)

# item.name = # => 'Bagle'
# items.unit_price # =>  '1.50'
# items.quantity # =>  '25'

# repo.update(item)

# updated_item = repo.find(1)
# updated_item.name # => 'Bagle'
# updated_item.unit_price # => '1.50'
# updated_item.quantity # => '25'
