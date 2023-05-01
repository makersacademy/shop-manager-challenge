require 'items_repository'

RSpec.describe ItemsRepository do

def reset_items_table
  seed_sql = File.read('spec/items_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_db_test' })
  connection.exec(seed_sql)
end

  before(:each) do 
    reset_items_table
  end

  it 'gets all items from the table ' do

    repo = ItemsRepository.new

    item = repo.all
    expect(item.length).to eq (2)
    expect(item.first.item_name).to eq 'Nice Mints'
    expect(item.first.item_price).to eq '50'
    expect(item.first.item_quantity).to eq ('12')
  end

  it 'finds item 1' do
    repo = ItemsRepository.new
    item = repo.find(1)
    expect(item.item_name).to eq 'Nice Mints'
    expect(item.item_price).to eq '50'
    expect(item.item_quantity).to eq '12'
  end

  it "find item 2" do
    repo = ItemsRepository.new
    item = repo.find(2)
    expect(item.item_name).to eq 'Best Beans'
    expect(item.item_price).to eq '1000'
    expect(item.item_quantity).to eq '5'
  end

  it 'creates a new item in the table' do

    repo = ItemsRepository.new

    new_item = Items.new
    new_item.item_name = 'Choclits'
    new_item.item_price = '999'
    new_item.item_quantity = '1'


    repo.create(new_item)

    items = repo.all
    last_item = items.last

    expect(last_item.item_name).to eq 'Choclits'
    expect(last_item.item_price).to eq '999'
    expect(last_item.item_quantity).to eq '1'
  end

  it 'deletes an item from the table' do
    repo = ItemsRepository.new

    id_to_delete = 1

    repo.delete(id_to_delete)

    all_items = repo.all
    expect(all_items.length).to eq 1
    expect(all_items.first.order_id).to eq nil
    expect(all_items.first.item_name).to eq 'Best Beans'
  end
end