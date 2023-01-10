require 'order_repository'
require 'order'

def reset_tables
  seed_sql = File.read('spec/seeds_shop_manager.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

RSpec.describe OrderRepository do
  before(:each) do 
    reset_tables
  end

  it "list all orders in shop" do
    order_repo = OrderRepository.new
    orders = order_repo.all
    expect(orders.length).to eq 2
  end 
end 
