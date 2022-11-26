require 'item_repository'

describe ItemRepository do
  def reset_items_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
    connection.exec(seed_sql)
  end

  def reset_orders_table
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_items_table
    reset_orders_table
  end
  describe "all" do
    it "returns all records from the items table" do
      repo = ItemRepository.new

      items = repo.all

      expect(items.length).to eq 2

      expect(items[0].id).to eq "1"
      expect(items[0].item_name).to eq 'Lego'
      expect(items[0].unit_price).to eq '9.99'
      expect(items[0].quantity).to eq '20'

      expect(items[1].id).to eq "2"
      expect(items[1].item_name).to eq 'My Little Pony'
      expect(items[1].unit_price).to eq '13.99'
      expect(items[1].quantity).to eq '50'
    end
  end
  describe "find_with_orders" do
    it "returns a particular item record by id from the items table includes an array of all orders associated with it" do
      repo = ItemRepository.new

      item = repo.find_with_orders(2)
        
      expect(item.item_name).to eq 'My Little Pony'
      expect(item.orders.length).to eq 2
      expect(item.orders.first.customer_name).to eq 'Simone'
    end
  end

  describe "create" do
    it "creates a new record in the items database" do
      repo = ItemRepository.new

      new_item = Item.new
      new_item.item_name = 'Magformers'
      new_item.unit_price = '24.99'
      new_item.quantity = 40


      query = repo.create(new_item)

      items = repo.all

      expect(items.length).to eq 3
    end
  end
end 