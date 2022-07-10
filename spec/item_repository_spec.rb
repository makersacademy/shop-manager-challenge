require 'item_repository'

def reset_items_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
    connection.exec(seed_sql)
end
  
describe ItemRepository do
    before(:each) do 
      reset_items_table
    end 
  
    it "returns all items" do
        repo = ItemRepository.new
        
        items = repo.all
        
        expect(items.length).to eq(3)
        
        expect(items[0].id).to eq(1)
        expect(items[0].name).to eq('item1')
        expect(items[0].price).to eq(23.76)
        expect(items[0].quantity).to eq(23)
        
        expect(items[1].id).to eq(2)
        expect(items[1].name).to eq('item2')
        expect(items[1].price).to eq(12.14)
        expect(items[1].quantity).to eq(45)
        
        expect(items[2].id).to eq(3)
        expect(items[2].name).to eq('item3')
        expect(items[2].price).to eq(384.38)
        expect(items[2].quantity).to eq(27)
    end

    it "returns a single item" do
        repo = ItemRepository.new
        
        item = repo.find(2)
        
        expect(item.id).to eq(2)
        expect(item.name).to eq('item2')
        expect(item.price).to eq(12.14)
        expect(item.quantity).to eq(45)
    end
end