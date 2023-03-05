require 'order_repository'

RSpec.describe OrderRepository do
  def reset_orders_table
    seed_sql = File.read('spec/test_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  
  describe OrderRepository do
    before(:each) do 
      reset_orders_table
    end

    it 'gets all orders' do
      repo = OrderRepository.new
      order = repo.all
      expect(order.length).to eq(2)
      expect(order[0].id).to eq(1)
      expect(order[0].date).to eq('2023-02-06')
      expect(order[0].customer_name).to eq('Paolo')
      expect(order[0].item_id).to eq(1)

      expect(order[1].id).to eq(2)
      expect(order[1].date).to eq('2023-02-21')
      expect(order[1].customer_name).to eq('Anna')
      expect(order[1].item_id).to eq(2)
    end

    it 'contains the new order' do
      repo = OrderRepository.new
      order = Order.new
      order.date = '2023-02-25'
      order.customer_name = 'Gino'
      order.item_id = 2

      repo.create(order) 
      orders = repo.all.sort_by(&:id)
      expect(orders[2].id).to eq(3)
      expect(orders[2].date).to eq('2023-02-25')
      expect(orders[2].customer_name).to eq('Gino')
      expect(orders[2].item_id).to eq(2)
    end
  end
end

