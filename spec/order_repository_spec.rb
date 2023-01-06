require_relative '../lib/order_repository'

RSpec.describe OrderRepository do
  def reset_tables
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_tables
  end

  it 'provides a list of all orders' do

    repo = OrderRepository.new
    
    orders = repo.all
    expect(orders.length).to eq 5
    expect(order[0].customer_name).to eq 'John Smith'
    expect(order[1].date).to eq '2023-01-02'
    expect(order[3].customer_name).to eq 'Elise Beer'
  end
end
