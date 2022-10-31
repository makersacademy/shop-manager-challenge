require_relative '../lib/order_repository'

describe OrderRepository do
  def reset_orders_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_orders_table
  end

  it "returns all order record" do
    repository = OrderRepository.new
    all_orders = repository.all_order
  
    expect(all_orders.first.customer_name).to eq ('Mike')
    expect(all_orders.first.date).to eq ('2022-10-01')
    expect(all_orders.first.item_name).to eq ('Iphone 11')
  end

  it "creates an order record" do
    repository = OrderRepository.new
    order = Order.new
    order.customer_name = 'Dasha'
    repository.create_order(order)

    item_order = OrderItem.new
    item_order.item_id = 1
    item_order.order_id = 4

    repository.add_order_item_id(item_order)

    all_orders = repository.all_order
    expect(all_orders).to include(
      have_attributes(
        customer_name: 'Dasha',
        date: '2022-10-31',
        item_name: 'Iphone 11'
      )
    )
  end
end
