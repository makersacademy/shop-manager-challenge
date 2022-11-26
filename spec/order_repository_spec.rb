require 'order_repository'

def reset_orders_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_database_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  it 'gets all orders' do 

    repo = OrderRepository.new

    orders = repo.all

    expect(orders.length).to eq 3

    expect(orders[0].id).to eq '1'
    expect(orders[0].customer_name).to eq 'Joe Bloggs'
    expect(orders[0].date).to eq '2022-11-21'

    expect(orders[1].id).to eq '2'
    expect(orders[1].customer_name).to eq 'Mrs Miggins'
    expect(orders[1].date).to eq '2022-11-23'

    expect(orders[2].id).to eq '3'
    expect(orders[2].customer_name).to eq 'Jane Appleseed'
    expect(orders[2].date).to eq '2022-11-17'
  end 

  it 'creates a new order' do 

    repo = OrderRepository.new 

    order = Order.new
    
    order.customer_name = 'Joe Schmoe'
    order.date = '24-Nov-2022'
    
    repo.create(order)
    
    all_orders = repo.all
    
    expect(all_orders.length).to eq 4
    expect(all_orders.last.id).to eq '4'
    expect(all_orders.last.customer_name).to eq 'Joe Schmoe'
    expect(all_orders.last.date).to eq '2022-11-24'

  end 
end
