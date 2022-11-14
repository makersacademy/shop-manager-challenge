# file: spec/item_repository_spec.rb

require 'order_repository'

def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  it '#list' do
    repo = OrderRepository.new
    orders = repo.list
    expect(orders.length).to eq 3

    expect(orders[0]['customer_name']).to eq 'Paul Jones'
    expect(orders[0]['order_date']).to eq '2022-08-25'

    expect(orders[1]['customer_name']).to eq 'Isabelle Mayhew'
    expect(orders[1]['order_date']).to eq '2022-10-13'

    expect(orders[2]['customer_name']).to eq 'Naomi Laine'
    expect(orders[2]['order_date']).to eq '2022-10-14'
  end

  xit '#create' do
    repo = OrderRepository.new
    order = Order.new
    order.customer_name = 'Father Christmas'
    order.order_date = '2022-12-25'

    repo.create(order)

    orders = repo.list
    last_order = orders.last
    expect(last_order.customer_name).to eq 'Father Christmas'
    expect(last_order.order_date).to eq '2022-12-25'
  end
end
