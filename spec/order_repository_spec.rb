require 'order_repository'


describe OrderRepository do

  def reset_orders_table
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_orders_table
  end

  it 'returns a list of all orders' do 
    repo = OrderRepository.new

    orders = repo.all 
    expect(orders.length).to eq 4
    expect(orders.first.id).to eq '1'
    expect(orders.first.customer_name).to eq 'Janet'
    expect(orders.first.order_date).to eq '2023-01-02'
    expect(orders.first.item_id).to eq '1'
  end

    # 2
    # get a single order
  it 'returns a single order' do
    repo = OrderRepository.new

    order = repo.find(1)
    expect(order.customer_name).to eq 'Janet'
    expect(order.order_date).to eq '2023-01-02' 
    expect(order.item_id).to eq '1'
  end


    # 3
    # get a single order
  it 'returns a single order' do

    repo = OrderRepository.new

    order = repo.find(3)
    expect(order.customer_name).to eq 'Emily'
    expect(order.order_date).to eq '2022-10-23' 
    expect(order.item_id).to eq '2'
  end

    # 4
    # Create a new order 
  it 'adds a new order' do
    repo = OrderRepository.new

    order = Order.new
    order.customer_name = 'Alfie'
    order.order_date = '2022-10-31'
    order.item_id = '1'


    repo.create(order)

    orders =  repo.all 

    last_order = orders.last 
    expect(last_order.customer_name).to eq 'Alfie'
    expect(last_order.order_date).to eq '2022-10-31'
    expect(last_order.item_id).to eq '1'
  end 
end 