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

      it 'returns the list of items' do
        repo = ItemRepository.new
        items = repo.all

        expect(items.length).to eq(2)

        expect(items.first.id).to eq('1')
        expect(items.first.name).to eq('chocolate')
      end

      it 'returns a single item' do
        repo = ItemRepository.new

        item = repo.find(1)
        expect(item.name).to eq('chocolate')
        expect(item.unit_price).to eq('7')
        expect(item.quantity).to eq('3')
      end

      it 'returns another single item' do
        repo = ItemRepository.new

        item = repo.find(2)
        expect(item.name).to eq('coffee')
        expect(item.unit_price).to eq('5')
        expect(item.quantity).to eq('1')
      end

      it 'returns a new item' do
        repo = ItemRepository.new

        new_item = Item.new
        new_item.name ='tea'
        new_item.unit_price = '4'
        new_item.quantity = '2'

        repo.create(new_item) # => nil

        items = repo.all
        last_item = items.last

        expect(last_item.name).to eq('tea')
        expect(last_item.unit_price).to eq('4')
        expect(last_item.quantity).to eq('2')
      end
    end

