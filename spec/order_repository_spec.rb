require 'order_repository'

RSpec.describe OrderRepository do
  def reset_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_table
  end

  it "returns an array of all orders" do
    repo = OrderRepository.new
    orders = repo.all
    expect(orders.count).to eq 3
    expect(orders[0].customer).to eq 'Yichao'
    expect(orders[0].date).to eq '2022-08-22'
  end

  it "creates a order" do
    repo = OrderRepository.new
    new_order = Order.new
    new_order.customer = 'Xinrui'
    new_order.date = '2022-09-10'
    repo.create(new_order)
    orders = repo.all
    expect(orders.count).to eq 4
    expect(orders.last.customer).to eq 'Xinrui'
  end
end