require "item_repository"
require "item"

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
            repo = ItemRepository.new
            items = repo.all
            expect(items.length).to eq 5
            expect(items.first.name).to eq "Royal Canin kitten food"
            expect(items.firs.unit_price).to eq "5"
            expect(items.first.quantity).to eq "20"
        end
    end

    describe "#item_quantity" do
    end

    describe "#create_item" do
    end

    describe "#all_orders" do
    end

    describe "#create_order" do
    end
end