require 'item_repository'


def reset_tables
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'items_orders_test' })
  connection.exec(seed_sql)
end


RSpec.describe ItemRepository do

  before(:each) do 
    reset_tables
  end

  describe "#all" do
    it "returns a list of all items" do
      repo = ItemRepository.new
      items = repo.all

      expect(items.length).to eq 5
      expect(items.first.id).to eq '1'
      expect(items.last.id).to eq '5'
      expect(items.first.name).to eq 'Henry Hoover'
      expect(items.last.name).to eq 'Panasonic Microwave'
      expect(items[2].unit_price).to eq '49'
      expect(items[3].quantity).to eq '34'
    end
  end

  describe "#create(new_item)" do
    it "adds a new item" do

    end
  end
end












# # Create an item
# # 1 (passing an Item object to #create)
# repo = ItemRepository.new

# new_item = Item.new
# new_item.name = 'Nespresso Coffee Machine'
# new_item.unit_price = 59
# new_item.quantity = 20

# repo.create(new_item)

# items = repo.all

# expect(items.last.id).to eq 6
# expect(items.last.name).to eq 'Nespresso Coffee Machine'
# expect(items.last.unit_price).to eq '59'
# expect(items.last.quantity).to eq '20'

# # 2 (passing a non Item object to #create)
# raise_error (with string, int, nil, etc.)
