# frozen_string_literal: false

require 'item_repository'
require 'item'

describe ItemRepository do
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