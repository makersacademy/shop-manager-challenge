require 'item'
require 'item_repository'

def reset_items_table
    seed_sql = File.read('schema/items_orders_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
    connection.exec(seed_sql)
end

describe ItemRepository do
  before do 
    reset_items_table
    @terminal_io = double :terminal_io
    @repo = ItemRepository.new(@terminal_io)
  end

    
  it 'lists all shop items' do
    items = @repo.list_all_items

    expect(items.length).to eq 4

    expect(items[0].id).to eq '1'
    expect(items[0].item_name).to eq 'Jollof rice'
    expect(items[0].unit_price).to eq '5.50'
    expect(items[0].quantity).to eq '200'

    expect(items[1].id).to eq '2'
    expect(items[1].item_name).to eq 'Playstation 5'
    expect(items[1].unit_price).to eq '479.99'
    expect(items[1].quantity).to eq '30'
  end

  it 'creates a new item' do
    
    # Prompt 1
    expect(@terminal_io).to receive(:puts).with('What is the name of the new item?')
    expect(@terminal_io).to receive(:gets).and_return('Samsung Galxy Fold 6')
    
    # Prompt 2
    expect(@terminal_io).to receive(:puts).with('What is the unit price of the new item?')
    expect(@terminal_io).to receive(:gets).and_return('1649')

    # Prompt 3
    expect(@terminal_io).to receive(:puts).with('What is the quantity of the new?')
    expect(@terminal_io).to receive(:gets).and_return('900')

    expect(@terminal_io).to receive(:puts).with('Item successfully created!')
    new_item = @repo.create_new_item


    all_items = @repo.list_all_items

    expect(all_items).to include(have_attributes(item_name: 'Samsung Galxy Fold 6', unit_price: '1649', quantity: '900'))
  end

end