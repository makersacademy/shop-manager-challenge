require "item_repository"


def reset_items_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end
RSpec.describe ItemRepository do
  before(:each) do
    reset_items_table
  end

  describe "#all_items" do
    it "outputs a list of items with their unit price and quantity" do
      io = double :io
      repo = ItemRepository.new(io)
      items = repo.all_items
      first_item = items.first

      expect(items.length).to eq 5
      expect(first_item.name).to eq "Royal Canin kitten food"
      expect(first_item.unit_price).to eq "5"
      expect(first_item.quantity).to eq "20"
    end
  end

  describe "#create_item" do
    it "creates a new item" do
      io = double :io
      repo = ItemRepository.new(io)
      new_item = double :new_item, name: "Butter", unit_price: "5", quantity: "12", orders: []
      
      repo.create_item(new_item)

      all_items = repo.all_items
      last_item = all_items.last

      expect(all_items.length).to eq 6
      expect(last_item.name).to eq "Butter"
      expect(last_item.unit_price).to eq "5"
      expect(last_item.quantity).to eq "12"
    end
  end

  describe "#all_orders" do
    it "outputs a list of all orders" do
      io = double :io
      repo = ItemRepository.new(io)
      orders = repo.all_orders
      last_order = orders.last
      expect(orders.length).to eq 3
      expect(last_order.customer_name).to eq "Hannah"
      expect(last_order.date).to eq "2022-10-01"
      expect(last_order.item_id).to eq "5"
    end
  end

  describe "#create_order" do
    it "adds a new order" do
      io = double :io
      repo = ItemRepository.new(io)
      new_order = double :new_order, customer_name: "Olivia", date: "2022-10-01", item_id: "4"

      repo.create_order(new_order)
      all_orders = repo.all_orders
      last_order = all_orders.last

      expect(all_orders.length).to eq 4
      expect(last_order.customer_name).to eq "Olivia"
      expect(last_order.date).to eq "2022-10-01"
      expect(last_order.item_id).to eq "4"
    end
  end
end