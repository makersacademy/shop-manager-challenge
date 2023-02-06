require 'item_repository'
require 'item'
require 'database_connection'
require 'pg'

RSpec.describe ItemRepository do
  DatabaseConnection.connect('shop_manager_test')
  def reset_items_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_items_table
  end

  it "returns a list of items" do
    repo = ItemRepository.new

    items = repo.all

    expect(items.length).to eq 2
    expect(items.first.id.to_i).to eq 1
    expect(items.first.name).to eq 'cereal'
  end

  it "returns a single item" do
    repo = ItemRepository.new
  
    item = repo.find(1)
  
    expect(item.id.to_i).to eq 1
    expect(item.name).to eq 'cereal'
    expect(item.unit_price.to_i).to eq 3
    expect(item.quantity.to_i).to eq 50
  end
  
  it "returns a single item" do
    repo = ItemRepository.new
  
    item = repo.find(2)
    expect(item.id.to_i).to eq 2
    expect(item.name).to eq 'tea'
    expect(item.unit_price.to_i).to eq 2
    expect(item.quantity.to_i).to eq 100
  end
end