require_relative '../lib/order_repository'
require_relative '../lib/order'
require_relative '../lib/database_connection'

RSpec.describe OrderRepository do

  def reset_shop_table
    seed_sql = File.read('spec/seeds_shop.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
    connection.exec(seed_sql)
  end
      
  before(:each) do
    reset_shop_table
  end

  it "#all - returns list of all Order objects" do 
    repo = OrderRepository.new
    orders = repo.all
    expect(orders.length).to eq 5
    expect(orders.first.id).to eq('1')
    expect(orders.first.customer).to eq('Sam')
    expect(orders.first.order_date).to eq('August')
  end

  it "#create - creates new Order object" do
    order = Order.new
    order.customer = 'Roy'
    order.order_date = 'July'

    repo = OrderRepository.new
    repo.create(order)

    orders = repo.all

    last_order = orders.last
    expect(last_order.customer).to eq('Roy')
    expect(last_order.order_date).to eq('July')
  end
end
