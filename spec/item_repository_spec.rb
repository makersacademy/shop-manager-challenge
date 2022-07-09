require 'item_repository'

def reset_items_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
    connection.exec(seed_sql)
end
  
describe ItemRepository do
    before(:each) do 
        reset_items_table
    end

    it "returns the first element" do 
        repo = ItemRepository.new
        items = repo.all

        expect(items.length).to eq 5

        expect(items[0].id).to eq '1'
        expect(items[0].item_name).to eq 'Cheese'
        expect(items[0].unit_price).to eq '$3.00'
        expect(items[0].quantity).to eq '33'
    end

    it "returns the second element from the database" do
        repo = ItemRepository.new
        items = repo.all

        expect(items[1].id).to eq '2'
        expect(items[1].item_name).to eq 'Cherries'
        expect(items[1].unit_price).to eq '$4.00'
        expect(items[1].quantity).to eq '368'
    end

    it "creeates a new item" do
        repo = ItemRepository.new
        item = Item.new
        item.item_name = 'Soup'
        item.unit_price = '3'
        item.quantity = '50'

        repo.create(item)

        items = repo.all

        last_item = items.last
        expect(last_item.item_name).to eq 'Soup'
        expect(last_item.unit_price).to eq '$3.00'
        expect(last_item.quantity).to eq '50'
    end

    # (your tests will go here).
end