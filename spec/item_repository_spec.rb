require 'item_repository'

RSpec.describe ItemRepository do
  def reset_items_table
    seed_sql = File.read('spec/test_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  
  describe ItemRepository do
    before(:each) do 
      reset_items_table
    end
  
    it 'returns two items' do
      repo = ItemRepository.new
      items = repo.all.sort_by(&:name)

      expect(items.length).to eq(2)
      
      expect(items[0].id).to eq(1)
      expect(items[0].name).to eq('Carbonara')
      expect(items[0].price).to eq(10)
      expect(items[0].quantity).to eq(2)
      
      expect(items[1].id).to eq(2)
      expect(items[1].name).to eq('Milk')
      expect(items[1].price).to eq(2)
      expect(items[1].quantity).to eq(3)
    
    end
  end

end
