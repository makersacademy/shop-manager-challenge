require "item_repository"

def reset_items_table
  seed_sql = File.read('spec/seed_item.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  context "all method" do
    it "returns 2 items" do
      repo = ItemRepository.new
      items = repo.all

      expect(items[0].id).to eq 1
      expect(items[0].name).to eq 'item1'
      expect(items[0].price).to eq 66.50
      expect(items[0].quantity).to eq 70

      expect(items[1].id).to eq 2
      expect(items[1].name).to eq 'item2'
      expect(items[1].price).to eq 33.25
      expect(items[1].quantity).to eq 35
    end
  end

  context "create method" do
    it "adds an item" do
      repo = ItemRepository.new
      item = Item.new
      item.name = 'item3'
      item.price = 5.99
      item.quantity = 300
      repo.create(item)
      expect(repo.all.length).to eq 3
    end
  end
end