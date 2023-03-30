require 'order_repository'

def reset_orders_table
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  seed_sql = File.read('spec/seeds_orders.sql')
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end
  let(:repo) { OrderRepository.new }

  it 'adds an order to orders table' do
    fake_date = Time.new(1999, 03, 21, 9, 30, 00).strftime("%Y-%m-%d")
    input_parameters = {item_id: 7, customer_id: 4}
    repo.add_order(input_parameters, date=fake_date)
    last_order = repo.last_order
    expect(last_order.item_id).to eq 7
    expect(last_order.customer_id).to eq 4
    expect(last_order.order_time).to eq "1999-03-21"
  end

  it 'checks the last order that was made' do
    last_order = repo.last_order
    expect(last_order.item_id).to eq 1
    expect(last_order.customer_id).to eq 5
    expect(last_order.order_time).to eq "2023-02-22"
  end
end


