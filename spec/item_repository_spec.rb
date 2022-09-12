require '../lib/item_repository'
require '../lib/database_connection'

DatabaseConnection.connect('shop_manager_library')

def reset_items_table
  seed_sql = File.read('../spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_library' })
  connection.exec(seed_sql)
end

RSpec.describe ItemRepository do
    before(:each) do 
        reset_items_table
      end
  it "constructs" do
    io = double(:io)
    repo = ItemRepository.new(io)
    result = repo.all
    expect(result.length).to eq 5
  end

  it "creates a new item" do
    io = double(:io)
    
    expect(io).to receive(:puts).with("What is the item name?")
    expect(io).to receive(:gets).and_return("Muff beard")
    expect(io).to receive(:puts).with("What is the unit price?")
    expect(io).to receive(:gets).and_return("90")
    expect(io).to receive(:puts).with("How many in stock?")
    expect(io).to receive(:gets).and_return("12")
    

    repo = ItemRepository.new(io)
    repo.create
    result = repo.all
    expect(result.length).to eq 6
    expect(result[5].name).to eq 'Muff beard'
  end
end
