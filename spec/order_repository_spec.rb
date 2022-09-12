require '../lib/order_repository'
require '../lib/database_connection'

DatabaseConnection.connect('shop_manager_library')

def reset_orders_table
  seed_sql = File.read('../spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_library' })
  connection.exec(seed_sql)
end

RSpec.describe OrderRepository do
    before(:each) do 
        reset_orders_table
      end
      
  it "constructs" do
    repo = OrderRepository.new
    result = repo.all
    expect(result.length).to eq 11
  end

  it "creates a new order" do
    repo = OrderRepository.new
    repo.create("Jason Boylan", ["1", "3", "5"])
    orders = repo.all
    expect(orders.length).to eq 14
    expect(orders[11].name).to eq 'shark vacuum'
  end
end