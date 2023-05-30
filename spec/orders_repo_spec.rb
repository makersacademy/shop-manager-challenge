require_relative '../lib/orders_repo' 

RSpec.describe OrderRepository do

  def reset_orders_table
    seed_sql = File.read('./spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'database_orders_test' })
    connection.exec(seed_sql)
  end

    before(:each) do 
      reset_orders_table
    end

  it 'returns the list of orders' do
    repo = OrderRepository.new

    orders = repo.all

    expect(orders.length).to eq(2)
    expect(orders.first.id).to eq('1') # => '1'
    expect(orders.first.customer_name).to eq('Khuslen')# => 'Khuslen'
    expect(orders.first.date_of_order).to eq('2023-05-26')
  end

    # 2
    # Get a single order
  it 'returns Khuslen as a single order' do
    
    repo = OrderRepository.new

    order = repo.find(1)

    expect(order.id).to eq('1')# => '1'
    expect(order.customer_name).to eq('Khuslen') # => 'Khuslen' 
    expect(order.date_of_order).to eq('2023-05-26')
  end 
    #3 
    # Get another single artist 
  it 'returns John as another order' do
    repo = OrderRepository.new
    order = repo.find(2)
    
    expect(order.id).to eq('2')# => '2'
    expect(order.customer_name).to eq('John') # => 'John'
    expect(order.date_of_order).to eq('2023-05-25')
  end 
    
    #4
    # Creates a new order
  it 'creates a new order' do
    
    repo = OrderRepository.new
    new_order = repo.create(customer_name: 'Billy', date_of_order: '2023-05-01')
    
    expect(new_order.id).to eq('3')
    expect(new_order.customer_name).to eq('Billy')
    expect(new_order.date_of_order).to eq('2023-05-01')
  end 
end
