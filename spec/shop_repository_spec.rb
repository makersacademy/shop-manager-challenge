require 'shop_repository'
require 'items'
require 'orders'

RSpec.describe ShopRepository do
  before(:all) { @repo = ShopRepository.new }

  it 'returns all shop items' do
    expect(@repo.all_items.length).to eq 3
  end
end

# What do you want to do?
#   1 = list all shop items
#   2 = create a new item
#   3 = list all orders
#   4 = create a new order
