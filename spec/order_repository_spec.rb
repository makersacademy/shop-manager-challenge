require 'order_repository'

RSpec.describe OrderRepository do
  def reset_orders_table 
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do
    reset_orders_table
  end
  
  context 'With the All Method' do
    it 'returns all the orders in the database' do
      repo = OrderRepository.new  
      orders = repo.all
      expect(orders.size).to eq 2
      expect(orders.first.id).to eq '1'
      expect(orders.first.customer_name).to eq 'Jack Skates'
      expect(orders.first.order_date).to eq '2023-04-28'
      expect(orders.first.item_id).to eq '1'
    end
  end

  context 'With the Find Method' do
    it 'returns the order with the matching id' do
      repo = OrderRepository.new
      order = repo.find(1)

      expect(order.id).to eq '1'
      expect(order.customer_name).to eq 'Jack Skates'
      expect(order.order_date).to eq '2023-04-28'
      expect(order.item_id).to eq '1'
    end
  end

  context 'With the Create Method' do
    it 'returns the orders with the newly created order' do
      repo = OrderRepository.new
      add_order = Order.new
      add_order.customer_name, add_order.order_date, add_order.item_id = 
        'Frank Reynolds', '2022-12-24', 1
      repo.create(add_order)
      orders = repo.all
      new_order = orders.last
      expect(new_order.id).to eq '3'
      expect(new_order.customer_name).to eq 'Frank Reynolds'
      expect(new_order.order_date).to eq '2022-12-24'
      expect(new_order.item_id).to eq '1'
    end
  end

  context 'With the Delete Method' do
    it 'returns the orders with the selected order deleted' do
      repo = OrderRepository.new
      repo.delete(1)
      orders = repo.all
      first_order = orders.first
      expect(first_order.id).to eq '2'
      expect(first_order.customer_name).to eq 'Charlie Kelly'
      expect(first_order.order_date).to eq '2020-08-12'
      expect(first_order.item_id).to eq '2'
    end
  end

  context 'With the Update Method' do
    it 'returns the orders with the selected order updated' do
      repo = OrderRepository.new
      original_order = repo.find(1)
      original_order.customer_name, original_order.order_date, original_order.item_id =
        'Sack Jates', '2022-03-12', 2
      repo.update(original_order)
      updated_order = repo.find(1)
      expect(updated_order.id).to eq '1'
      expect(updated_order.customer_name).to eq 'Sack Jates'
      expect(updated_order.order_date).to eq '2022-03-12'
      expect(updated_order.item_id).to eq '2'
    end
  end
end