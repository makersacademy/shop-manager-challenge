require 'item_repository'

def reset_items_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  context "#all" do
    it 'initiates' do
      repo = ItemRepository.new
    end

    it 'returns the correct amount of unique types of items' do
      repo = ItemRepository.new
      items = repo.all
      expect(items.length).to eq 5
    end

    it 'returns the correct data' do
      repo = ItemRepository.new
      items = repo.all
      expect(items[0].id).to eq '1'
      expect(items[0].name).to eq 'corn'
      expect(items[0].unit_price).to eq '1.5'
      expect(items[0].quantity).to eq '250'
    end

    it 'returns the correct data' do
      repo = ItemRepository.new
      items = repo.all
      expect(items[3].id).to eq '4'
      expect(items[3].name).to eq 'carrot'
      expect(items[3].unit_price).to eq '1.25'
      expect(items[3].quantity).to eq '500'
    end
  end

  context '#create_item' do
    it 'creates a new item' do
      repo = ItemRepository.new
      repo.create('celery', '2.25', '125')
      items = repo.all
      expect(items[5].id).to eq '6'
      expect(items[5].name).to eq 'celery'
      expect(items[5].unit_price).to eq '2.25'
      expect(items[5].quantity).to eq '125'
    end
  end
end