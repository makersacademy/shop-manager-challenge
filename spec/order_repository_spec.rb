require 'order_repository'
require 'item_repository'

def reset_orders_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe OrderRepository do
  before(:each) do
    reset_orders_table
  end

  it "gets all orders" do
    repo = OrderRepository.new
    orders = repo.all

    expect(orders.length).to eq 3
    expect(orders[0].id).to eq '1'
    expect(orders[0].customer).to eq 'Quack Overflow'
    expect(orders[0].date).to eq '2023-04-01'
  end
end
