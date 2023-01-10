require 'item_repository'
require 'reseed_shop_manager_db'
require 'item'
require 'database_connection'

RSpec.describe ItemRepository do
    describe ItemRepository do
    before(:each) do
    reseed_tables

    end

    it "returns all items requested" do
        repo = ItemRepository.new
        items = repo.all
        
        expect(items.length).to eq 6
        expect(items[0].item_name).to eq "Super Shark Vacuum Cleaner"
        expect(items[0].unit_price).to eq "99"
        expect(items[0].quantity).to eq "30"
        expect(items[0].order_id).to eq "1"

    
        expect(items[1].item_name).to eq "Makerspresso Coffee Machine"
        expect(items[1].unit_price).to eq "69"
        expect(items[1].quantity).to eq "15"
        expect(items[1].order_id).to eq "2"

    end

    it "creates a new item at request" do

        repo = ItemRepository.new
        new_item = Item.new
        
        new_item.item_name = 'LG TV'
        new_item.unit_price = '2000'
        new_item.quantity = '7'
        new_item.order_id = '2'
        
        repo.create(new_item)

        expect(repo.all.length).to eq 7
        expect(repo.all.last.item_name).to eq 'LG TV'
        expect(repo.all.last.unit_price).to eq '2000'
        expect(repo.all.last.quantity).to eq '7'
        expect(repo.all.last.order_id).to eq '2'

    end
end

end

