require 'item_repository'
require 'item'
require 'database_connection'

def reset_shop_database
  seed_sql = File.read('spec/seeds_shop_manager.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec_params(seed_sql)
end

describe ItemRepository do
  before(:each) do
    reset_shop_database
  end

  context "Rspec tests " do
    it 'all_items# method ' do
      io = double :io 
      repo = ItemRepository.new(io)
      items = repo.all_items
      expect(items.length).to eq(5)
      expect(items[0].name).to eq('bread')
      expect(items[0].id).to eq(1)
      expect(items[4].name).to eq('lettuce')
      expect(items[4].price).to eq(0.45)
    end

    it "add_item spec " do
      io = double :io
      repo = ItemRepository.new(io)
      expect(io).to receive(:puts).with("Add item")
      expect(io).to receive(:puts).with("What is the item id?")
      expect(io).to receive(:gets).and_return(6)
      expect(io).to receive(:puts).with("What is the item name?")
      expect(io).to receive(:gets).and_return("chocolate")
      expect(io).to receive(:puts).with("What is the item price?")
      expect(io).to receive(:gets).and_return(2.00)
      expect(io).to receive(:puts).with("How many do you have to sell?")
      expect(io).to receive(:gets).and_return(5)
      expect(io).to receive(:puts).with("Item added!")
      repo.add_item
      items = repo.all_items
      expect(items.length).to eq(6)
      expect(items.last.name).to eq('chocolate')
      expect(items.last.price).to eq(2.00)
      expect(items.last.quantity).to eq(5)

    end
  end
end

# expect(io).to receive(:puts).with("What is your name?")
# expect(io).to receive(:gets).and_return("Kay")
# expect(io).to receive(:puts).with("Hello, Kay!")
