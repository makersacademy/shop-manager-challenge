require 'order_repository'

RSpec.describe OrderRepository do

def reset_orders_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

before(:each) do
  reset_orders_table
end

  it 'returns the list of orders' do
    repo = AlbumRepository.new

    orders = repo.all
    expect(orders.length).to eq '2'
    expect(orders[0].id).to eq '1'
    expect(orders[0].order_id).to eq '1'
    expect(orders[0].customer_name).to eq 'Evelina'
    expect(orders[0].date_of_order).to eq '2022-07-25'
  end
end