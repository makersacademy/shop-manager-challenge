# frozen_string_literal: false

require 'item'
require 'item_repository'

describe Item do
  it 'constructs with order_id unassigned' do
    item = Item.new
    expect(item.order_id).to eq nil
  end

  it 'updates the order_id of an item' do
    item = Item.new
    item_id = 1
    order_id = 2
    item.update_order_id(order_id, item_id)

    # needed to use ItemRepo to access id
    # otherwise need to create new ids
    repo = ItemRepository.new
    items = repo.list
    # update moves it to end of list
    item1 = items.last
    expect(item1.order_id).to eq '2'
  end
end
