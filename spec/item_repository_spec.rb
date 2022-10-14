require_relative '../lib/item_repository'
require_relative '../lib/item'
require_relative '../lib/database_connection'

RSpec.describe ItemRepository do

  def reset_shop_table
    seed_sql = File.read('spec/seeds_shop.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
    connection.exec(seed_sql)
  end
      
  before(:each) do
    reset_shop_table
  end

  it "#all - returns list of all Item objects" do 
    repo = ItemRepository.new
    items = repo.all
    expect(items.length).to eq 4
    expect(items.first.id).to eq('1')
    expect(items.first.name).to eq('Pen')
    expect(items.first.price).to eq('£1')
    expect(items.first.quantity).to eq('10')
  end

  it "#create - creates new Item object" do
    item = Item.new
    item.name = 'Tippex'
    item.price = '£3'
    item.quantity = '7'
    
    repo = ItemRepository.new
    repo.create(item)
    
    items = repo.all
    
    expect(items).to include(
        have_attributes(
            name: 'Tippex',
            price: '£3',
            quantity: '7'
        )
        )
  end
end
