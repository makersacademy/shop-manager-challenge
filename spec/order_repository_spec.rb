require 'order_repository'
require 'reseed_shop_manager_db'
require 'order'
require 'database_connection'
RSpec.describe OrderRepository do
  describe OrderRepository do
    before(:each) do 
      reseed_tables
    end
    it 'returns all orders' do
      repo = OrderRepository.new
      orders = repo.all   
      expect(orders.length).to eq 6
      expect(orders[0].order_date).to eq '2023-01-01'
      expect(orders[0].customer_name).to eq 'Ana'
      expect(orders[0].item_id).to eq '1'
      expect(orders[1].customer_name).to eq 'Sam'
      expect(orders[1].order_date).to eq '2023-02-01'
      expect(orders[1].item_id).to eq '2'
    end
    it 'creates a new order' do
      repo = OrderRepository.new
      new_order = Order.new
      new_order.order_date = '2023-05-01'
      new_order.customer_name = 'Bernard'
      new_order.item_id = '2'     
      repo.create(new_order)  
      expect(repo.all.length).to eq 7
      expect(repo.all.last.order_date).to eq '2023-05-01'
      expect(repo.all.last.customer_name).to eq 'Bernard'
      expect(repo.all.last.item_id).to eq '2'
    end
  end
end
