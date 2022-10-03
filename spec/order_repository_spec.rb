require 'order_repository'

RSpec.describe OrderRepository do
  def reset_orders_table
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_orders_table
  end

  it 'gets all orders' do
    repo = OrderRepository.new

    orders = repo.all

    expect(orders.length).to eq 2

    expect(orders[0].id).to eq "1"
    expect(orders[0].customer).to eq "Piper"
    expect(orders[0].date).to eq "1102022"
    expect(orders[0].item_id).to eq "1"

    expect(orders[1].id).to eq "2"
    expect(orders[1].customer).to eq "Lily"
    expect(orders[1].date).to eq "1062022"
    expect(orders[1].item_id).to eq "2"
  end

  it 'creates an order' do
    repo = OrderRepository.new

    new_order = Order.new
    new_order.customer = "Abi"
    new_order.date = "02102022"
    new_order.item_id = 2

    repo.create(new_order)

    all_orders = repo.all

    expect(all_orders). to include(
      have_attributes(
        customer: new_order.customer,
        date: "2102022",
        item_id: "2"
      )
    )
  end
end