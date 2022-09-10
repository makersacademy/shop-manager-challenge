require 'item'
require 'item_repository'

RSpec.describe ItemRepository do
  def reset_tables
    seed_sql = File.read('spec/seeds_tests.sql')
    user = ENV['PGUSER1'].to_s
    password = ENV['PGPASSWORD'].to_s
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test', user: user, password: password })

    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_tables
  end

  describe "#all_items" do
    it "returns array of all shop items" do
      repo = ItemRepository.new
      result = repo.all_items
      expect(result.length).to eq 2
      expect(result[0].name).to eq "Item 1"
      expect(result[0].price).to eq "1"
      expect(result[0].stock_qty).to eq "5"
      expect(result[1].name).to eq "Item 2"
      expect(result[1].price).to eq "2"
      expect(result[1].stock_qty).to eq "10"
    end
  end

  describe "#create_item" do
    it "returns array of all shop items" do
      item = Item.new
      item.name = "Item 3"
      item.price = "3"
      item.stock_qty = "15"

      repo = ItemRepository.new
      repo.create_item(item)
      result = repo.all_items.last
      expect(result.name).to eq "Item 3"
      expect(result.price).to eq "3"
      expect(result.stock_qty).to eq "15"
    end
  end


end
