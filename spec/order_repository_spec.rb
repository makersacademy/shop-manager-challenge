require 'order_repository'
require 'database_connection'
require 'order'


def reset_items_orders_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_solo_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_items_orders_table
  end

  it 'lists all orders in the database' do
    repo = OrderRepository.new

    orders = repo.all

    expect(orders.length).to eq 2

    expect(orders[0].id).to eq  '1'
    expect(orders[0].customer).to eq  'Anna'
    expect(orders[0].date).to eq  '2022-08-15'

    expect(orders[1].id).to eq  '2'
    expect(orders[1].customer).to eq  'David'
    expect(orders[1].date).to eq  '2022-08-23'
  end

  it 'creates a new order in the databse' do 
    repo = OrderRepository.new

    order_new = Order.new
    order_new.customer = 'Chris'
    order_new.date = '2022, 08, 27'
    order_new.items = ['2']

    repo.create(order_new)

    repo_updated = repo.all

    expect(repo_updated.length).to eq 3
    expect(repo_updated[2].customer).to eq 'Chris'
    expect(repo_updated[2].date).to eq '2022-08-27'
  end
end