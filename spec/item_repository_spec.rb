require 'item_repository'
require 'order_repository'
require 'item'
require 'order'

RSpec.describe 'ItemRepository' do
  let(:repo) { ItemRepository.new }
  
  def reset_tables
    sql = File.read('./spec/seeds_test.sql')
    connection = PG.connect({ host: ENV['DATABASE_HOST'], dbname: ENV['DATABASE_NAME'] })
    connection.exec(sql) 
  end

  before(:each) do
    reset_tables
  end
  
  describe '#create' do
    it 'creates a new item' do
      item = Item.new(
        name: 'Beanbag',
        price: 79,
        stock: 46
      )
      repo.create(item)
      items = repo.all
      expect(items.length).to eq 4
      expect(items.last.name).to eq 'Beanbag'
      expect(items.last.price).to eq '79'
      expect(items.last.stock).to eq '46'
      expect(items.last.id).to eq '4'
    end
  end

  describe '#all' do
    it 'returns all items' do
      items = repo.all
      expect(items.length).to eq 3
      expect(items[0].name).to eq 'Sun Lamp'
      expect(items[1].price).to eq '189'
      expect(items[2].stock).to eq '95'
    end
  end
end
