require 'item_repository'

describe ItemRepository do 

  def reset_items_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_database' })
    connection.exec(seed_sql)
  end 

  before(:each) do
    reset_items_table
  end

  context '#all' do 
    it 'returns a list of all items' do 
    
      repo = ItemRepository.new

      items = repo.all

      items.length # =>  3

      expect(items[0].id).to eq '1'
      expect(items[0].name).to eq 'B1 Pencils'
      expect(items[0].unit_price).to eq '£0.70'
      expect(items[0].stock_count).to eq '506'

      expect(items[2].id).to eq '3'
      expect(items[2].name).to eq 'Blue Biros'
      expect(items[2].unit_price).to eq '£1.00'
      expect(items[2].stock_count).to eq '325'
    end 
  end 
end
