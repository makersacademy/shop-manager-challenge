require 'order_repository'

def reset_order_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({host:'127.0.0.1',dbname:'items_orders_test'})
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do
    reset_order_table
  end

  it 'returns all the order item objects' do
    repo = OrderRepository.new
    orders = repo.all

    expect(orders.length).to eq 3
    expect(orders.first.id).to eq 1
    expect(orders.first.customer_name).to eq 'Ryan'
    expect(orders.first.placed_date).to eq '2023-01-08'
    expect(orders.first.items).to eq ['Apple','Orange']
  end
end
