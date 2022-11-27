require 'Item_repository'

RSpec.describe ItemRepository do
  def reset_items_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_items_table
  end

  describe '#all' do
    it 'returns the list of items' do
      repo = ItemRepository.new

      items = repo.all

      expect(items.length).to eq(6)
      expect(items.first.id).to eq('1')
      expect(items.first.item_name).to eq("Electric Guitar")
      expect(items.first.unit_price).to eq("500")
      expect(items.first.quantity).to eq("25")
    end
  end

  describe '#create' do
    it 'inserts a new Item into the Items library' do
      repo = ItemRepository.new

      item = Item.new
      item.item_name = 'Bass Guitar'
      item.unit_price = '365'
      item.quantity = '99'

      repo.create(item)

      all_items = repo.all
      
      expect(all_items).to include(
        have_attributes(
          item_name: item.item_name, 
          unit_price: item.unit_price,
          quantity: item.quantity
        )
      )
    end
  end
end
