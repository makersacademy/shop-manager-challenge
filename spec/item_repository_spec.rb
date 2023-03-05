require 'item_repository'
RSpec.describe ItemRepository do
    def reset_items_table
        seed_sql = File.read('spec/seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'order_items_test' })
        connection.exec(seed_sql)
    end
    before(:each) do 
        reset_items_table
      end
    it 'returns length of table' do
        repo = ItemRepository.new
        items = repo.all
        expect(items.length).to eq (4)
    end
    it 'returns what the first unit price is' do
        repo = ItemRepository.new
        items = repo.all
        expect(items.first.unit_price).to eq ("3")
    end

end
#items.length # =>  4items.first.id # =>  1
#items.last.unit_price # =>  'David'
#items.first.quantity # =>  'April 2022'