require_relative '../lib/item_repo'

def reset_items_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'store_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  it 'returns a list of all items, ' do 
    repo = ItemRepository.new 

    item = repo.all
    expect(item.length).to eq(2)
    expect(item[1].id).to eq('2')  # => '1'
    expect(item[1].item_name).to eq ("beer")
  end 


  it 'returns a single item and info from order_id = "1"' do 
    repo = ItemRepository.new 

    item = repo.find(1)
    expect(item.item_name).to eq('pizza')
    expect(item.price).to eq(4.99)
  end 

  it 'creates a new album' do 
    repo = ItemRepository.new 

    new_item = Item.new 
    new_item.item_name = 'gum'
    new_item.quantity = 10
    new_item.price = 1.0
    new_item.order_id = 1

     repo.create(new_item)
     all_items = repo.all

      expect(all_items[2].item_name).to eq 'gum'
      expect(all_items[2].price).to eq 1
  end
 end 

