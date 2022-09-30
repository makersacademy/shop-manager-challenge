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
      
  it 'shows all orders' do
    repo = OrderRepository.new
    expect(repo.all.length).to eq 11
  end

  it 'creates an order' do
    repo = OrderRepository.new
    repo.create_order("Mike Williams", [1, 3, 4])
    expect(repo.all.length).to eq 12
  end

  it 'creates a new order' do
    repo = OrderRepository.new
    repo.create_order("Me Will", [1, 4])
    expect(repo.all.length).to eq 12
    expect(repo.all[11].customer_name).to eq 'Me Will'
  end
end