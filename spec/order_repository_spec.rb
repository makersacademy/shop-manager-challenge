require 'order_repository'

RSpec.describe OrderRepository do

  def reset_shop_table
    seed_sql = File.read('spec/seeds_shop.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_challenge_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_shop_table
  end

  it 'returns the list of all the orders' do
    repo = OrderRepository.new

    orders = repo.all 

    expect(orders.length).to eq 3
    expect(orders.first.id).to eq '1'
    expect(orders.first.customer_name).to eq "John Smith"
  end

  it 'creates a new order' do
    repo = OrderRepository.new

    new_order = Order.new
    new_order.customer_name = 'Sadie Long'
    new_order.order_date = '19/11/2021'

    repo.create(new_order)

    all_orders = repo.all

    expect(all_orders).to include (
      have_attributes(
        customer_name: new_order.customer_name,
        order_date: new_order.order_date
      ))
  end
end
