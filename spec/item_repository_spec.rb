require 'item_repository'

def reset_database
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_database
  end
  
  describe "#all" do
    context "when asking for a list of items" do
      it "returns all items" do
        repo = ItemRepository.new
        items = repo.all
        expect(items.length).to eq 10
      end
    end
  end
end
