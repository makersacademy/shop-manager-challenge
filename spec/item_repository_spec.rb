require '../lib/item_repository'
require '../lib/database_connection'

DatabaseConnection.connect('shop_manager_library')

def reset_items_table
  seed_sql = File.read('../spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_library' })
  connection.exec(seed_sql)
end

RSpec.describe ItemRepository do
    before(:each) do 
        reset_items_table
      end
  it "constructs" do
    repo = ItemRepository.new
    items = repo.all
    expect(items.length).to eq 5
  end

  it "fills correctly" do
    repo = ItemRepository.new
    items = repo.all
    expect(items[0].name).to eq 'shark vacuum'
    expect(items[4].name).to eq 'ball waxer'
    expect(items[2].quantity).to eq "10"
    expect(items[1].unit_price).to eq "8"
  end

  it "creates an item" do
    repo = ItemRepository.new
    repo.create("Dog biscuits", 10, 220)
    items = repo.all
    expect(items.length).to eq 6
    expect(items[5].name).to eq 'Dog biscuits'
    expect(items[5].unit_price).to eq '10'
  end
end
