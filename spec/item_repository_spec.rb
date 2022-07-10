require 'item_repository'

def reset_items_table
    seed_sql = File.read('spec/seed.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
end

RSpec.describe do
    before(:each) do
        reset_items_table
    end
    it "gets all items" do
        repo = ItemRepository.new

        items = repo.all

        expect(items[0].id).to eq 1
        expect(items[0].name).to eq "Strength Potion"
        expect(items[0].price).to eq  8.99
        expect(items[0].quantity).to eq  100

        expect(items[1].id).to eq 2
        expect(items[1].name).to eq  "Med Kit"
        expect(items[1].price).to eq  25.50
        expect(items[1].quantity).to eq  43
    end
end