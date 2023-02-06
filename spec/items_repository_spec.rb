require 'items_repository'

def reset_users_table
    seed_sql = File.read('spec/shop_manager_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
    connection.exec(seed_sql)
end

RSpec.describe ItemRepository do
    
    before(:each) do 
        reset_users_table
    end

    it "tests the all function by returning a full list of items in the shop" do
        repo1 = ItemRepository.new
        full_item_list = repo1.list_all
        expect(full_item_list.length).to eq 12
        expect(full_item_list.first.item_name).to eq 'Carton of eggs'
    end

    it "tests the find function by returning the information on the last item in the list, a box of grapes" do
        repo1 = ItemRepository.new
        grapes = repo1.select_item(12)
        expect(grapes.item_name).to eq "Box of grapes"
        expect(grapes.quantity).to eq "100"
        expect(grapes.price).to eq "3"
    end

    it "tests the create function by adding a thirteenth item and reading back info on the full list" do
        repo1 = ItemRepository.new
        newitem = Item.new
        newitem.item_name = "Orange juice"
        newitem.price = 3
        newitem.quantity = 60
        repo1.create(newitem)
        expect(repo1.list_all.length).to eq 13
        expect(repo1.list_all.last.item_name).to eq "Orange juice"
    end
end