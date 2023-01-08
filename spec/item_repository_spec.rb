require_relative '../lib/item_repository'

def reset_items_table
  seed_sql = File.read('spec/items_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  it "#all returns all items in the items table" do
    repo = ItemRepository.new

    items = repo.all

    expect(items.length).to eq(2)

    expect(items[0].id).to eq(1)
    expect(items[0].name).to eq 'Mustang'
    expect(items[0].price).to eq '$47,630.00'
    expect(items[0].quantity).to eq 200

    expect(items[1].id).to eq(2)
    expect(items[1].name).to eq 'Fiesta'
    expect(items[1].price).to eq "$19,060.00"
    expect(items[1].quantity).to eq 600
  end

  it "#creates a new item in the items table" do
    repo = ItemRepository.new

    new_item = Item.new
    new_item.name = 'Focus'
    new_item.price = 26040
    new_item.quantity = 350
    repo.create(new_item)
    expect(repo.all).to include(
      have_attributes(name: 'Focus', price: "$26,040.00", quantity: 350)
    )
  end

  it "#find returns an item based on the id passed as argument to method" do
    repo = ItemRepository.new
    item = repo.find(1)
    expect(item.id).to eq (1)
    expect(item.name).to eq 'Mustang'
    expect(item.price).to eq '$47,630.00'
    expect(item.quantity).to eq 200
  end

  it "#update changes the value of a key inputted as argument" do
    repo = ItemRepository.new
    repo.update_quantity(1)
    item = repo.find(1)
    expect(item.quantity).to eq 199
  end

end