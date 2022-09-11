require 'item_repository'

RSpec.describe ItemRepository do
  # snippet and function call copied and modified from repository class recipe
  def reset_tables
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_tables
  end

  describe "#all" do
    it "returns a list of all items as Item objects" do
      item_repo = ItemRepository.new
      items = item_repo.all
      expect(items.length).to eq 2
      expect(items.first.name).to eq "Super Shark Vacuum Cleaner"
      expect(items.first.unit_price).to eq 99
      expect(items.first.stock_quantity).to eq 30
      expect(items.last.name).to eq "Makerspresso Coffee Machine"
      expect(items.last.unit_price).to eq 69
      expect(items.last.stock_quantity).to eq 15
    end
  end
  
  describe "#create(item)" do
    it "creates an item record from Item object" do
      item_repo = ItemRepository.new
      item = Item.new
      item.name = "Super Smart Genius Toaster"
      item.unit_price = 79.0
      item.stock_quantity = 10
      item_repo.create(item)
      latest_item = item_repo.all.last
      expect(latest_item.name).to eq "Super Smart Genius Toaster"
      expect(latest_item.unit_price).to eq 79
      expect(latest_item.stock_quantity).to eq 10
    end
  end
end
