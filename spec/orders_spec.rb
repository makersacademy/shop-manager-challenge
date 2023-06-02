require 'order_repository'

RSpec.describe OrderRepository do
  def reset_shop_manager_table
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_shop_manager_table
  end

  it "returns two orders" do
    repo = OrderRepository.new

    orders = repo.all
    expect(orders.length).to eq 2 # => 2
    expect(orders.first.customer_name).to eq "Joe Hannis" 
    expect(orders.first.order_date).to eq '2023-05-25' 
  end

  it 'returns the order with the specified ID' do
    repo = OrderRepository.new
    order = repo.find(2)

    expect(order.customer_name).to eq('Sean Peters')
    expect(order.order_date).to eq('2023-05-26')
  end

  it "creates a new instance in the database and returns it" do
    repo = OrderRepository.new

    new_order = Order.new
    new_order.customer_name = 'Pegah'
    new_order.order_date = '2023-08-08'
    
    repo.create(new_order)
    
    all_orders = repo.all
    expect(all_orders.last.customer_name).to eq('Pegah') 
    expect(all_orders.last.order_date).to eq('2023-08-08')
  end

  it "deletes an instance by its id" do
    repo = OrderRepository.new

    id_to_delete = 1
    
    repo.delete(id_to_delete)
    
    all_orders = repo.all
    expect(all_orders.length).to eq 1 # => 1
    expect(all_orders.first.id).to eq '2' # => '2'
    expect(all_orders.first.customer_name).to eq 'Sean Peters'
  end

  it "updates an instance by its id" do
    repo = OrderRepository.new

    order = repo.find(1)

    order.customer_name = 'Pegah'
    order.order_date = '2023-12-12'
    order.id = 1

    repo.update(order)
    updated_order = repo.find(1)
    expect(updated_order.customer_name).to eq 'Pegah'
    expect(updated_order.order_date).to eq '2023-12-12'
  end
end
