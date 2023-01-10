require 'item_repository'
require 'item'

def reset_tables
  seed_sql = File.read('spec/seeds_shop_manager.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

RSpec.describe ItemRepository do
  before(:each) do 
    reset_tables
  end

  it "list all items in shop" do
    item_repo = ItemRepository.new
    items = item_repo.all
    expect(items.length).to eq 4 
  end 
end 
