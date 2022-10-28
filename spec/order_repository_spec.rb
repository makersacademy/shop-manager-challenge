require_relative '../lib/order_repository'

def reset_shop_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_shop_table
  end

  it 'returns all orders on record' do
    repo = OrderRepository.new
    orders = repo.all
    expect(orders.length).to eq 5
    expect(orders[0].customer_name).to eq 'Sia'
    expect(orders[2].date).to eq '2022-08-27'
  end


end