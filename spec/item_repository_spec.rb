require 'item_repository'

def reset_shop_tables
  seed_sql = File.read('spec/seeds_shop_tables.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe ItemRepository do
  before(:each) do
    reset_shop_tables
  end

  it 'gets a list of all item objects' do
    repo = ItemRepository.new
    items = repo.all

    expect(items.length).to eq 2

    expect(items[0].id).to eq 1
    expect(items[0].name).to eq 'Hoover'
    expect(items[0].unit_price).to eq 99.99
    expect(items[0].quantity).to eq 20
  end
end