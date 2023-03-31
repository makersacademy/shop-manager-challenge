require 'order'
require 'order_repository'
require 'item'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'items_orders_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_tables
  end

  it "finds all order" do
    repo = OrderRepository.new

    orders = repo.all

    expect(orders.length).to eq 3

    expect(orders.first.id).to eq 1
    expect(orders.first.customer_name).to eq 'Sam'
    expect(orders.first.date).to eq '2023-03-31'
  end
end