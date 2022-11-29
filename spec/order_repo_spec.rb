require 'order_repository'
require 'shop_item_repository'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_challenge_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_tables
  end

  it 'returns all orders' do 
    repo = OrderRepository.new

    orders = repo.all

    expect(orders.length).to eq(3)

    expect(orders[0].id).to eq('1')
    expect(orders[0].customer_name).to eq('David')
    expect(orders[0].date_placed).to eq('2022-11-08')

    expect(orders[1].id).to eq('2')
    expect(orders[1].customer_name).to eq('Anna')
    expect(orders[1].date_placed).to eq('2022-11-10')
  end

  it 'creates a new order' do 
    repo = OrderRepository.new 
    shop_repo = ShopItemRepository.new

    order = Order.new
    order.customer_name = 'Bob'
    order.date_placed = '2022-11-15'
    repo.create(order)
    order.id = repo.all.last.id
    name_of_item = 'bananas'
    item_added_to_order = shop_repo.create_item_object(name_of_item)

    quantity_added = 5
    repo.add_item_to_new_order(order, item_added_to_order, quantity_added)


    orders = repo.all

    expect(orders.last.customer_name).to eq('Bob')
    expect(orders.last.date_placed).to eq('2022-11-15')
  end
end