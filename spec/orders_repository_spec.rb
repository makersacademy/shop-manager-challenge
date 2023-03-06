require 'orders_repository'

RSpec.describe OrdersRepository do
  def reset_orders_table
    seed_sql = File.read('spec/seeds_shop_manager_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_orders_table
  end
  
  it 'Gets all orders.' do
    repo = OrdersRepository.new
    orders = repo.all
    expect(orders.length).to eq 6
    expect(orders[0].id).to eq 1
    expect(orders[0].order_date).to eq '2023-03-05 00:00:00'
    expect(orders[0].item_id).to eq 2
    expect(orders[0].customer_id).to eq 1

    expect(orders[1].id).to eq 2
    expect(orders[1].order_date).to eq '2023-03-06 00:00:00'
    expect(orders[1].item_id).to eq 1
    expect(orders[1].customer_id).to eq 1
  end

  it 'Gets a single order.' do
    repo = OrdersRepository.new
    order = repo.find(3)
    expect(order.id).to eq 3
    expect(order.order_date).to eq '2023-03-07 00:00:00'
    expect(order.customer_id).to eq 2
  end

  it 'Creates an order.' do
    repo = OrdersRepository.new
    order = Order.new
    order.order_date = '2023-03-11 00:00:00'
    order.item_id = 3
    order.customer_id = 1
    repo.create(order)
    orders = repo.all
    newest_order = orders.last
    expect(newest_order.id).to eq 7
  end

  it 'Update an order' do
    repo = OrdersRepository.new
    order = repo.find(2)
    order.order_date = '2023-03-06 00:00:00'
    repo.update(order)
    updated_order = repo.find(2)
    expect(updated_order.order_date).to eq '2023-03-06 00:00:00'
  end

  it 'Delete an order' do
    repo = OrdersRepository.new
    orders = repo.all
    new_order1 = Order.new
    new_order1.order_date = '2023-03-08 00:00:00'
    new_order1.item_id = 4
    new_order1.customer_id = 1
    repo.create(new_order1)

    new_order2 = Order.new
    new_order2.order_date = '2023-03-09 00:00:00'
    new_order2.item_id = 5
    new_order2.customer_id = 2
    repo.create(new_order2)
    
    repo.delete(7)
    orders = repo.all
    expect(orders.length).to eq 7
  end
end
