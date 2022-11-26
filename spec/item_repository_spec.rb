require "item_repository"

RSpec.describe ItemRepository do

  def reset_table
    seed_sql = File.read('spec/seeds.sql')

    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_challenge' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_table
  end

# these tests are almost the same as the ones in order_repository_spec.rb
# you will find more details and comments there to undertsand the testing process
  it 'lists all the items in the item repository' do
    repo = ItemRepository.new
    items_list = repo.all
    expect(items_list.length).to eq 5
    expect(items_list.first.name).to eq 'screws'
    expect(items_list.first.unit_price).to eq 5
    expect(items_list.last.name).to eq 'level'
    expect(items_list.last.quantity).to eq 70
  end

  it 'creates a new item and add it to the item repository' do
    repo = ItemRepository.new
    items_list = repo.all
    expect(items_list.length).to eq 5
    expect(items_list.last.name).to eq 'level'

    new_item = Item.new
    new_item.name = 'Super Shark Vacuum Cleaner'
    new_item.unit_price = 99
    new_item.quantity = 30

    updated_repo = ItemRepository.new
    updated_repo.create(new_item)
    updated_items_list = updated_repo.all

    expect(updated_items_list.length).to eq 6
    expect(updated_items_list.last.name).to eq 'Super Shark Vacuum Cleaner'
    expect(updated_items_list.last.unit_price).to eq 99
    expect(updated_items_list.last.quantity).to eq 30

    expect(updated_items_list).to include(
      have_attributes(
      name: new_item.name,
      unit_price: new_item.unit_price,
      quantity: new_item.quantity
      )
    )
  end


end
