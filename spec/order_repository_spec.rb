require 'order_repository'

RSpec.describe OrderRepository do 

  def reset_orders_table
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  
  describe OrderRepository do
    before(:each) do 
      reset_orders_table
    end

    it 'Get all orders with item name' do 

      repo = OrderRepository.new

      orders = repo.all

      expect(orders.length).to eq 8
      expect(orders[0].id).to eq 1
      expect(orders[0].customer_name).to eq 'customer 1'
      expect(orders[0].order_date).to eq '2022-01-25'
      expect(orders[0].item_id).to eq 1
      expect(orders[0].item_name).to eq 'item 1'
    end

    it 'Creates a new order' do 

      repository = OrderRepository.new

      order = Order.new
      order.customer_name = 'customer 9'
      order.order_date = '2022-01-25'
      order.item_id = 1

      repository.create(order)

      all_items = repository.all
      last_order= all_items.last
      expect(last_order.customer_name).to eq 'customer 9'
      expect(last_order.order_date).to eq '2022-01-25'
      expect(last_order.item_id).to eq 1  
    end

    xit 'Raises error when item_id is not int' do 
      repository = OrderRepository.new

      order = Order.new
      order.customer_name = 'customer 9'
      order.order_date = '2022-01-25'
      order.item_id = 'customer 9'

      expect{ repository.create(order) } .to raises error "test"
    end

    xit 'Raises error when item_id does not exist' do 
      repository = OrderRepository.new

      order = Order.new
      order.customer_name = 'customer 9'
      order.order_date = '2022-01-25'
      order.item_id = 5

      expect{ repository.create(order) } .to raises error "test"
    end

    xit 'Raises error when order_date is not a date' do 

      repository = OrderRepository.new

      order = Order.new
      order.customer_name = 'customer 9'
      order.order_date = 'customer 9'
      order.item_id = 1

      expect{ repository.create(order) } .to raises error "test"
    end
  end
end
