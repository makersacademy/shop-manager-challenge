require 'item_repository'

RSpec.describe ItemRepository do

def reset_items_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

before(:each) do
  reset_items_table
end

  it 'returns the list of items' do
    repo = ItemRepository.new

   items = repo.all
    expect(item.length).to eq 2
    expect(item[0].id).to eq '1'
    expect(item[0].name).to eq 'iPhone'
    expect(items[0].price).to eq '700'
  end
