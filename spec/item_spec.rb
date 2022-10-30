# frozen_string_literal: false

require 'item'

describe Item do
  it 'constructs with order_id unassigned' do
    item = Item.new
    expect(item.order_id).to eq nil
  end

  # it 'updates the order_id of an item' do
  #   item = Item.new
  #   item_id = 1
  #   order_id = 2
  #   item.update_order_id(item_id, order_id)

  #   expect()
    
  # end
end
