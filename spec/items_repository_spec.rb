require './lib/items_repository'
# require './lib/orders_repository'

def reset_students_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_students_table
  end

  context "Listing shop items" do
    it "lists first record" do
      repo = ItemRepository.new

      items = repo.all

      expect(items.length).to eq 2  
      
      expect(items.first.id).to eq '1'
      expect(items.first.name).to eq 'Scrabble'
      expect(items.first.price).to eq '14'
      expect(items.first.quantity).to eq '100'
    end
  
    it "lists 2nd record" do
      repo = ItemRepository.new

      items = repo.all

      expect(items.length).to eq 2

      expect(items[1].id).to eq '2'
      expect(items[1].name).to eq 'Catan'
      expect(items[1].price).to eq '20'
      expect(items[1].quantity).to eq '25'
    end
  end

  context "Adding new items" do
    it "Adds a new item to the end of the table" do
      
      repo = ItemRepository.new
      item = Item.new

      item.name = 'Codenames'
      item.price = 10
      item.quantity = 60

      repo.create(item) # =>
      all_items = repo.all
      last_item = all_items.last
      
      expect(last_item.name).to eq 'Codenames'
      expect(last_item.price).to eq '10'
      expect(last_item.quantity).to eq '60'
    end
  end
end