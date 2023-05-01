require 'order_repository'

describe OrderRepository do
  def reset_orders_table
    seed_sql = File.read('spec/shop_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_orders_table
  end

  it 'Should return all rows as an array of order objects when the all method is called' do
    repo = OrderRepository.new
    result = repo.all
    expect(result.length).to eq 9
    expect(result.first.id).to eq '1'
    expect(result.last.id).to eq '9'
    expect(result[4].customer_name).to eq 'Mrs Peacock'
    expect(result[5].item_id).to eq '1'
  end
end

describe OrderRepository do
  context 'Empty databse' do
    def reset_table
      seed_sql = File.read('spec/empty_seeds.sql')
      connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
      connection.exec(seed_sql)
    end

    before(:each) do
      reset_table
    end

    it 'Should return all rows as an array when the all method is called' do
      repo = OrderRepository.new
      expect(repo.all).to eq []
    end
  end
end
