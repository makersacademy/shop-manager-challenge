require 'item_repository.rb'
require 'item.rb'

RSpec.describe ItemRepository do
    def reset_items_repos
        seed_sql = File.read('spec/seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop' })
        connection.exec(seed_sql)
    end
    before(:each) do 
        reset_items_repos
    end
    it 'selects all items' do
        itRe = ItemRepository.new()
        result = itRe.all()
        expect(
            result[0].id
        ).to eq "1"
    end
    it 'selects item at ID' do
        itRe = ItemRepository.new()
        #
        result = itRe.find(2,"id")
        expect(
            result.id
        ).to eq "2"
    end
    it 'creates an item' do
        itRe = ItemRepository.new()
        #
        itM = Item.new()
        itM.name="Test";
        itM.unitprice="10"
        itM.quantity="25"
        itRe.create(itM)
        #
        result = itRe.find("Test","name")
        expect(
            result.name
        ).to eq "Test"
    end
end