require 'item_repository'
require 'order_repository'

RSpec.describe 'integration' do
  context 'when creating an order' do
    it 'updates quantity of corresponding item' do
      item_repo = ItemRepository.new
      order_repo = OrderRepository.new
      order = Order.new
      order.customer_name = 'Francesca'
      order.date_placed = '2023-04-28'
      order.item_id = 2
      order_repo.create(order)

      item = item_repo.find(order.item_id)
      expect(item.quantity).to eq 1
    end
  end
end