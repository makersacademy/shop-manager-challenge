require 'item_repository'
require 'database_connection'
require 'item'


def reset_items_orders_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_solo_test'})
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_orders_table
  end

  it 'lists all items in the database' do
    repo = ItemRepository.new

    items = repo.all

    expect(items.length).to eq 2

    expect(items[0].id).to eq  '1'
    expect(items[0].name).to eq  '1984'
    expect(items[0].price).to eq  '9.99'
    expect(items[0].quantity).to eq  '54'

    expect(items[1].id).to eq  '2'
    expect(items[1].name).to eq  'War and peace'
    expect(items[1].price).to eq  '7.99'
    expect(items[1].quantity).to eq  '14'
  end

  it 'creates a new item in the databse' do 
    repo = ItemRepository.new

    item_new = Item.new
    item_new.name = 'Pride and prejudice'
    item_new.price = '8.99'
    item_new.quantity = '26'

    repo.create(item_new)

    repo_updated = repo.all

    expect(repo_updated.length).to eq 3
    expect(repo_updated[2].name).to eq 'Pride and prejudice'
    expect(repo_updated[2].price).to eq '8.99'
    expect(repo_updated[2].quantity).to eq '26'
  end
end