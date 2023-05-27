require 'item_repository'


RSpec.describe ItemRepository do
  def reset_shop_manager_table
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end


  before(:each) do 
    reset_shop_manager_table
  end

  it "returns two items" do
    repo = ItemRepository.new

    items = repo.all
    expect(items.length).to eq 2 # => 2
    expect(items.first.name).to eq "CPU" # => 'CPU'
    expect(items.first.unit_price).to eq '199.99' # => '199.99'
    expect(items.first.quantity).to eq '10' # => '10'
  end

  it 'returns the item with the specified ID' do
    repo = ItemRepository.new
    item = repo.find(2)

    expect(item.name).to eq('GPU')
    expect(item.unit_price).to eq('499.99')
    expect(item.quantity).to eq("5")
  end

  it "creates a new instance in the database and returns it" do
    repo = ItemRepository.new

    new_item = Item.new
    new_item.name = 'Keyboard'
    new_item.unit_price = 59.99
    new_item.quantity = 8
    
    repo.create(new_item)
    
    all_items = repo.all
    expect(all_items.last.name).to eq('Keyboard') 
    expect(all_items.last.unit_price).to eq('59.99')
    expect(all_items.last.quantity).to eq('8')
  end

  it "deletes an instance by its id" do
    repo = ItemRepository.new

    id_to_delete = 1
    
    repo.delete(id_to_delete)
    
    all_items = repo.all
    expect(all_items.length).to eq 1 # => 1
    expect(all_items.first.id).to eq '2' # => '2'
    expect(all_items.first.name).to eq 'GPU'
  end

  it "updates an instance by its id" do
    repo = ItemRepository.new

    item = repo.find(1)

    item.name = 'INTEL CORE 2 DUO'
    item.unit_price = '35.75'
    item.quantity = '27'
    item.id = 1


    repo.update(item)

    updated_item = repo.find(1)
    expect(updated_item.name).to eq 'INTEL CORE 2 DUO'
    expect(updated_item.unit_price).to eq '35.75'
    expect(updated_item.quantity).to eq '27'
  end
end