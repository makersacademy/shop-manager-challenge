require 'order_repository'

def reset_orders_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'orders_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  it "returns a list of all shop orders" do
    repository = OrderRepository.new
    orders = repository.all
    expect(orders.length).to eq 3

    expect(orders[0].id).to eq 1
    expect(orders[0].customer_name).to eq 'Penaldo'
    expect(orders[0].date).to eq '2022-03-01'

    expect(orders[1].id).to eq 2
    expect(orders[1].customer_name).to eq 'Penzema'
    expect(orders[1].date).to eq '2022-12-04'

    expect(orders[2].id).to eq 3
    expect(orders[2].customer_name).to eq 'Messi'
    expect(orders[2].date).to eq '2022-10-06'
  end

  it "creates a new shop order" do
    repository = OrderRepository.new
    order = double :order, customer_name: 'Pessi', date: '2022-08-20'
  
    repository.create(order)
    all_orders = repository.all

    last = all_orders.last
    expect(last.customer_name).to eq 'Pessi'
    expect(last.date).to eq '2022-08-20'
  end

    it "find a specific order record" do
    repository = OrderRepository.new
    # only 1 order has been made for this id
    item = repository.find_items_by_order_id(3)

    expect(item.orders.length).to eq 1
  end
end