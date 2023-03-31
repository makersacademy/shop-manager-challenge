require 'item'
require 'item_repository'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'items_orders_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_tables
  end

  it "finds all items" do
    repo = ItemRepository.new

    items = repo.all

    expect(items.length).to eq 7

    expect(items.first.id).to eq 1
    expect(items.first.name).to eq 'Pizza'
    expect(items.first.unit_price).to eq 9.99
    expect(items.first.quantity).to eq 100
  end
  # (your tests will go here).
end