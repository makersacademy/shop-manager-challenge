require 'order_repository'

describe OrderRepository do

  def reset_order_table
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_order_table
  end

  it 'get all orders' do

    repo = OrderRepository.new

    order = repo.all

    expect(order.length).to eq 2

    expect(order[0].id).to eq '1'
    expect(order[0].customer_name).to eq 'customer1'
    expect(order[0].order_date).to eq '2022-01-01'
    expect(order[0].stock_id).to eq '1'

    expect(order[1].id).to eq '2'
    expect(order[1].customer_name).to eq 'customer2'
    expect(order[1].order_date).to eq '2022-02-02'
    expect(order[1].stock_id).to eq '1'
  end
  it 'get a single order' do

    repo = OrderRepository.new

    order = repo.find(1)

    expect(order.id).to eq '1'
    expect(order.customer_name).to eq 'customer1'
    expect(order.order_date).to eq '2022-01-01'
    expect(order.stock_id).to eq '1'

    order = repo.find(2)

    expect(order.id).to eq '2'
    expect(order.customer_name).to eq 'customer2'
    expect(order.order_date).to eq '2022-02-02'
    expect(order.stock_id).to eq '1'
  end

  it 'create a new object' do

    repo = OrderRepository.new
    order = Order.new

    order.id = '3'
    order.customer_name = 'customer3'
    order.order_date = '2022-03-03'
    order.stock_id = '2'

    repo.create(order)

    orders = repo.all

    expect(orders).to include(
      have_attributes(
        id: order.id,
        customer_name: order.customer_name,
        order_date: order.order_date,
        stock_id: order.stock_id
        )
      )
  end

  it 'deletes all objects' do

    repo = OrderRepository.new
    repo.delete(1)
    repo.delete(2)
    order = repo.all
    expect(order.length).to eq 0

  end
  
  it 'deletes one object' do

    repo = OrderRepository.new
    repo.delete(1)
    order = repo.all
    expect(order.length).to eq 1

    expect(order[0].id).to eq '2'
    expect(order[0].customer_name).to eq 'customer2'
    expect(order[0].order_date).to eq '2022-02-02'
    expect(order[0].stock_id).to eq '1'
  end
  
  it 'update existing entry' do

    repo = OrderRepository.new

    order = repo.find(2)

    expect(order.id).to eq '2'
    expect(order.customer_name).to eq 'customer2'
    expect(order.order_date).to eq '2022-02-02'
    expect(order.stock_id).to eq '1'

    repo.update(2)

    order = repo.find(2)

    expect(order.id).to eq '2'
    expect(order.customer_name).to eq 'new_customer2'
    expect(order.order_date).to eq '2022-03-03'
    expect(order.stock_id).to eq '1'
  end
end
