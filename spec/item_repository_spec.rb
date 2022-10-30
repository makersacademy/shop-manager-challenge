# frozen_string_literal: false

require 'item_repository'
require 'item'

# file: spec/item_repository_spec.rb
def reset_items_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end
  it '#list' do
    repo = ItemRepository.new
    items = repo.list

    expect(items.length).to eq 6  

    expect(items[0].id).to eq '1'
    expect(items[0].item_name).to eq 'Apple'
    expect(items[0].price).to eq '90'

    expect(items[1].id).to eq '2'
    expect(items[1].item_name).to eq 'Banana'
    expect(items[1].price).to eq '75'
  end

  it '#create' do
    repo = ItemRepository.new
    item = Item.new
    item.item_name = 'Orange'
    item.price = '80'

    repo.create(item)

    items = repo.list
    new_entry = items.last
    expect(new_entry.item_name).to eq 'Orange'
    expect(new_entry.price).to eq '80'
  end
end

