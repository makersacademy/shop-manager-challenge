require 'order_repo'

RSpec.describe OrderRepo do 
def reset_albums_table 
  seed_sql = File.read('spec/seeds_order_repo.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end
before(:each) do 
  reset_albums_table
end 
it 'returns 1 input order' do 
  repo = OrderRepo.new 
  orders = repo.all 

  expect(orders.first.customer).to eq('Alex')
  expect(orders.first.date).to eq('16/6/2016')
  expect(orders.first.order_id).to eq('1')
end 
end 