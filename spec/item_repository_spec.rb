require 'item_repository'

def reset_items_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  context '#all' do
    it 'returns all items' do
      repo = ItemRepository.new

      items = repo.all

      expect(items.length).to eq 2

      expect(items[0].id).to eq '1'
      expect(items[0].name).to eq 'Flake'
      expect(items[0].unit_price).to eq '99'
      expect(items[0].quantity).to eq '10'

      expect(items[1].id).to eq '2'
      expect(items[1].name).to eq 'Twix'
      expect(items[1].unit_price).to eq '110'
      expect(items[1].quantity).to eq '5'
    end
  end

  context '#find' do
    it 'returns the first item' do
      repo = ItemRepository.new

      item = repo.find(1)

      expect(item.id).to eq '1'
      expect(item.name).to eq 'Flake'
      expect(item.unit_price).to eq '99'
      expect(item.quantity).to eq '10'
    end

    it 'returns the second item' do
      repo = ItemRepository.new

      item = repo.find(2)

      expect(item.id).to eq '2'
      expect(item.name).to eq 'Twix'
      expect(item.unit_price).to eq '110'
      expect(item.quantity).to eq '5'
    end
  end

  context '#create' do
    it 'creates a new item' do
      repo = ItemRepository.new

      item = Item.new

      item.name = 'Freddo'
      item.unit_price = 25
      item.quantity = 30

      repo.create(item) 

      items = repo.all

      last_item = items.last

      expect(last_item.id).to eq '3'
      expect(last_item.name).to eq 'Freddo'
      expect(last_item.unit_price).to eq '25'
      expect(last_item.quantity).to eq '30'
    end
  end
end
