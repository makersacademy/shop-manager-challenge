require 'item_repository'

def reset_items_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

Rspec.describe ItemRepository do
  before(:each) do
    reset_items_table
  end

  context "all items" do
    it "returns all items" do
      repo = ItemRepository.new

      items = repo.all

      expect(items.length).to eq 7
      expect(items[0].id).to eq 1
      expect(items[0].name).to eq 'blueberries'
      expect(items[0].unit_price).to eq '4'
      expect(items[0].quantity).to eq '30'
    end
  end

  context "find a singular item" do
    xit "returns the first item" do
      repo = ItemRepository.new

      item = repo.find(1)

      expect(item.name).to eq 'blueberries'
      expect(item.unit_price).to eq '4'
      expect(item.quantity).to eq '30'
    end
  end

  context "add an item" do
    xit "adds strawberries item" do
      repo = ItemRepository.new

      item = Item.new
      item.name = 'strawberries'
      item.unit_price = '4'
      item.quantity = '40'

      repo.create(item)

      items = repo.all
      expect(items.length).to eq 8
      expect(items.last.id).to eq '8'
      expect(items.last.name).to eq 'strawberries'
    end
  end

  context "delete an item" do
    xit "deletes first item" do
      repo = ItemRepository.new

      id = 1

      repo.delete(id)

      items = repo.all
      expect(items.length).to eq 6
      expect(items.first.id).to eq '2'
    end
  end

  context "update an item's quantity" do
    xit "updates first item quanity to 20" do
      repo = ItemRepository.new

      item = repo.find(1)

      item.quantity = "20"

      repo.update_quantity(item)

      updated_item = repo.find(1)

      expect(updated_item.quantity).to eq "20"
    end
  end

  context "find item by order" do
    xit "finds all the items in an order" do
      repo = ItemRepository.new

      order = repo.find_by_order(1)
      items = order.items

      expect(items.length).to eq 4
    end
  end
end
