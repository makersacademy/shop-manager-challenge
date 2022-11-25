  require 'order_repository'

  def reset_orders_table
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  
  RSpec.describe OrderRepository do
    before(:each) do 
      reset_orders_table
    end
    
    it 'returns all orders' do
      repo = OrderRepository.new
      orders = repo.all
      
      expect(orders.length).to eq 2
      
      expect(orders[0].customer_name).to eq 'Harry'
      expect(orders[0].date).to eq '2022-11-25'
      expect(orders[1].customer_name).to eq 'Jack'
      expect(orders[1].date).to eq '2022-11-24'
    end

    it 'creates a new order' do
      repo = OrderRepository.new

      new_order = Order.new
      new_order.customer_name = 'Lauren'
      new_order.date = '2022-11-23'
      repo.create(new_order)
      
      orders = repo.all
      expect(orders.length).to eq 3
      expect(orders[2].customer_name).to eq 'Lauren'
      expect(orders[2].date).to eq '2022-11-23'
    end

    it 'deletes a order by id' do

      repo = OrderRepository.new 
      repo.delete(1)
      orders = repo.all
      expect(orders.length).to eq 1
      expect(orders[0].customer_name).to eq 'Jack'

    end

    it 'finds a specfic order' do
      repo = OrderRepository.new
      order = repo.find(2)

      expect(order.customer_name).to eq 'Jack'
      expect(order.date).to eq '2022-11-24'
    end
  end