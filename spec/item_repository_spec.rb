require 'item_repository'
require 'item'

def reset_items_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'items_orders_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  it "returns all items and their properties" do
    repo = ItemRepository.new

    items = repo.all

    expect(items.length).to eq 6

    expect(items[0].id).to eq '1'
    expect(items[0].name).to eq 'White Desk Lamp'
    expect(items[0].unit_price).to eq '18'
    expect(items[0].quantity).to eq'12'
    expect(items[1].id).to eq '2'
    expect(items[1].name).to eq 'Mahogani Dining Table'
    expect(items[1].unit_price).to eq '235'
    expect(items[1].quantity).to eq'5'
    expect(items[2].id).to eq '3'
    expect(items[2].name).to eq 'Oak Bookshelf'
    expect(items[2].unit_price).to eq '80'
    expect(items[2].quantity).to eq'15'
    expect(items[3].id).to eq '4'
    expect(items[3].name).to eq 'Oriental Rug'
    expect(items[3].unit_price).to eq '139'
    expect(items[3].quantity).to eq'21'
    expect(items[4].id).to eq '5'
    expect(items[4].name).to eq 'Aloe Vera Houseplant'
    expect(items[4].unit_price).to eq '12'
    expect(items[4].quantity).to eq'150'
    expect(items[5].id).to eq '6'
    expect(items[5].name).to eq 'Leather Sofa'
    expect(items[5].unit_price).to eq '1699'
    expect(items[5].quantity).to eq'2'
  end

  it "creates a new item and adds it to the database" do
    repo = ItemRepository.new

    item = Item.new
    item.name = 'Luxury Armchair'
    item.unit_price = 240
    item.quantity = 7

    repo.create(item)

    expect(repo.all.last.name).to eq 'Luxury Armchair'
    expect(repo.all.last.unit_price).to eq '240'
    expect(repo.all.last.quantity).to eq '7'
  end 
end