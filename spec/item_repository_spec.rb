require 'item_repository'
require 'item'

def reset_database
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

RSpec.describe ItemRepository do
  before(:each) do 
    reset_database
  end
  
  describe "#all" do
    it "returns all items" do
      repo = ItemRepository.new
      items = repo.all
      expect(items.length).to eq 10
    end
  end
  
  describe "#create" do
    it "adds a new item to the database" do
      repo = ItemRepository.new
      item = Item.new
      item.name = "Bike"
      item.price = 475
      item.quantity = 3
      repo.create(item)
      expect(repo.all.length).to eq 11
      expect(repo.all.last.name).to eq "Bike"
    end
  end
  
  describe "#find" do
    it "returns a single item" do
      repo = ItemRepository.new
      item = repo.find(1)
      expect(item.name).to eq "Bread"
    end
  end
  
  describe "#update_quantity" do
    it "reduces the stock level by 1 unit" do
      repo = ItemRepository.new
      repo.update_quantity(1)
      item = repo.find(1)
      expect(item.quantity).to eq "9"
    end
  end
end
