require 'order_repository'

def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  it 'initializes' do
    repo = OrderRepository.new
  end

  context '#all' do
    it 'returns the correct amount of orders' do
      repo = OrderRepository.new
      orders = repo.all
      expect(orders.length).to eq 5
    end

    it 'returns the correct data' do
      repo = OrderRepository.new
      orders = repo.all
      expect(orders[0].id).to eq '1'
      expect(orders[0].customer_name).to eq 'Harry'
      expect(orders[0].order_date).to eq '2023-03-04'
    end

    it 'returns the correct data' do
      repo = OrderRepository.new
      orders = repo.all
      expect(orders[3].id).to eq '4'
      expect(orders[3].customer_name).to eq 'Albus'
      expect(orders[3].order_date).to eq '2023-02-24'
    end
  end

  context '#create_order' do
    it 'creates a new order' do
      repo = OrderRepository.new
      repo.create_order('Voldemort', '2023-03-07')
      orders = repo.all
      expect(orders[5].id).to eq '6'
      expect(orders[5].customer_name).to eq 'Voldemort'
      expect(orders[5].order_date).to eq '2023-03-07'
    end
  end
end