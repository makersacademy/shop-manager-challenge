require 'item_repository'

def reset_tables
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
end

RSpec.describe ItemRepository do
    before(:each) { reset_tables }

    it "gets all items" do
        repo = ItemRepository.new
        items = repo.all
        expect(items.length).to eq  3
        expect(items[0].id).to eq  '1'
        expect(items[0].name).to eq  'shirt'
        expect(items[1].id).to eq  '2'
        expect(items[1].name).to eq  'jeans'
        expect(items[2].id).to eq '3'
        expect(items[2].name).to eq  'hoodie'
    end
end