# file: spec/item_repository_spec.rb

require './lib/item_repository'

def reset_item_table
    seed_sql = File.read('spec/seeds_shop_manager_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
end
  
describe ItemRepository do
    before(:each) do 
        reset_item_table
    end

    it 'tests the the all method' do 
        repo = ItemRepository.new
        item = repo.all

        expect(item.length).to eq 2
        expect(item[0].id).to eq '1'
        expect(item[0].name).to eq 'hammer'  
        expect(item[0].price).to eq '5.99'
        expect(item[0].quantity).to eq '10'
    end

    it 'tests the find method' do
        repo = ItemRepository.new
        item = repo.find(2)

        expect(item).to (
            having_attributes(
              id: '2',
              name: 'glue',
              price: '2.99',
              quantity: '5'
            )
          )
    end

    it 'tests the create method' do
        repo = ItemRepository.new

        item = Item.new
        item.name = 'pencil'
        item.price = 1.99
        item.quantity = 1
        
        repo.create(item)
        create_item = repo.all
        
        expect(create_item.last.name).to eq 'pencil'
        expect(create_item.last.price).to eq '1.99'
    end
end