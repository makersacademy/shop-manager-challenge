require 'item_repository'

RSpec.describe ItemRepository do
  def reset_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_table
  end

  it "returns an array of all shop items" do
    repo = ItemRepository.new
    items = repo.all
    expect(items.count).to eq 5
    expect(items[0].name).to eq 'voile'
    expect(items[0].unit_price).to eq 13
    expect(items[0].quantity).to eq 260
  end

  it "creates a shop item" do
    repo = ItemRepository.new
    new_item = Item.new
    new_item.name = 'coffee pods'
    new_item.unit_price = '5'
    new_item.quantity = '10'
    repo.create(new_item)
    items = repo.all
    expect(items.count).to eq 6
    expect(items.last.name).to eq 'coffee pods'
  end
end