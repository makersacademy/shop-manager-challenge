require 'item_repository'

describe ItemRepository do
    def reset_items_table
        seed_sql = File.read('spec/seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_challenge_test' })
        connection.exec(seed_sql)
    end

    before(:each) do 
        reset_items_table
    end

    it 'returns all items and their info' do
        repo = ItemRepository.new
        item = repo.all
        expect(item[0].id).to eq 1
        expect(item[0].item).to eq "Bread"
        expect(item[0].price).to eq "9.99"
        expect(item[0].quantity).to eq 5
        expect(item[0].order_id).to eq "1"

        expect(item[1].id).to eq 2
        expect(item[1].item).to eq "Butter"
        expect(item[1].price).to eq "7.99"
        expect(item[1].quantity).to eq 1
        expect(item[1].order_id).to eq "1"
    end

    it 'updates the table with a new item' do
        repo = ItemRepository.new

        new_item = Item.new
        new_item.item = "Jam"
        new_item.price = "11.54"
        new_item.quantity = 8
        new_item.order_id = "2"

        repo.create(new_item)

        all_items = repo.all

        expect(all_items).to include(have_attributes(item: new_item.item, price: new_item.price, quantity: new_item.quantity, order_id: new_item.order_id,))
    end
end