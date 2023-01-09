require 'item_repository'

RSpec.describe ItemRepository do
    def reset_items_table
        seed_sql = File.read('spec/seeds_items.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
        connection.exec(seed_sql)
    end

    before(:each) do 
        reset_items_table
    end

    it "returns full list of items" do
        repo = ItemRepository.new
        items = repo.all

        expect(items.length).to eq 3
        expect(items[0].id).to eq 1
        expect(items[0].name).to eq "coffee machine"
        expect(items[0].unit_price).to eq 80
        expect(items[0].quantity).to eq 30
    end

    context "it finds a single item" do
        it "returns coffee machine as item" do
            repo = ItemRepository.new
            item = repo.find(1)

            expect(item.id).to eq 1
            expect(item.name).to eq "coffee machine"
            expect(item.unit_price).to eq 80
            expect(item.quantity).to eq 30
        end

        it "returns vacuum cleaner as item" do
            repo = ItemRepository.new
            item = repo.find(2)

            expect(item.id).to eq 2
            expect(item.name).to eq "vacuum cleaner"
            expect(item.unit_price).to eq 100
            expect(item.quantity).to eq 15
        end

        it "returns toaster as item" do
            repo = ItemRepository.new
            item = repo.find(3)

            expect(item.id).to eq 3
            expect(item.name).to eq "toaster"
            expect(item.unit_price).to eq 30
            expect(item.quantity).to eq 60
        end
    end

    it "creates a new Item object that is present in list of items array" do
        repo = ItemRepository.new

        new_item = Item.new
        new_item.name = 'fridge'
        new_item.unit_price = 200
        new_item.quantity = 20

        repo.create(new_item)
        items = repo.all

        expect(items).to include (
            have_attributes(
                id: 4,
                name: 'fridge',
                unit_price: 200,
                quantity: 20
            )
        )
    end

    it "increases stock of item selected by id" do
        repo = ItemRepository.new

        repo.increase_stock(1)
        item_one = repo.find(1)
        repo.increase_stock(2)
        item_two = repo.find(2)

        expect(item_one.quantity).to eq 40
        expect(item_two.quantity).to eq 25
    end
end