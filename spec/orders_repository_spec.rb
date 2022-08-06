require "orders_repository"

def reset_items_items_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end
RSpec.describe ItemsRepository do
  before(:each) do 
    reset_items_items_table
  end
  it 'Get all orderss' do
    repo = OrdersRepository.new
    orders = repo.all

    expect(orders.length).to eq  2
    expect(orders[0].id).to eq "1"
    expect(orders[0].customer_name).to eq  'Anna'
    expect(orders[0].order_date).to eq  '4 May 2022'
    expect(orders[0].item_id).to eq '2'

    expect(orders[1].id).to eq  "2"
    expect(orders[1].customer_name).to eq  'Mike'
    expect(orders[1].order_date).to eq  '15 jun 2022'
    expect(orders[1].item_id).to eq '1'
  end 
  it 'Get a single order' do
    repo = OrdersRepository.new
    orders = repo.find(1)

    expect(orders.id).to eq  "1"
    expect(orders.customer_name).to eq 'Anna'
    expect(orders.order_date).to eq  '4 May 2022'
    expect(orders.item_id).to eq '2'
  end 

end 
