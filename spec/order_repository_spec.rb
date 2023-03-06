
require 'order_repository'

describe OrderRepository do
  def reset_tables
    seed_sql = File.read('seeds/test_seed.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_tables
  end

  it 'returns an array of all the orders' do
    repo = OrderRepository.new

    orders = repo.all

    expect(orders.length).to eq 3
    expect(orders.first.customer_name).to eq 'Ryan Lai'
    expect(orders.first.order_date).to eq '12-07-2001'
  end

  it 'returns an array of information about each ordered item from an order, given the order id' do
    repo = OrderRepository.new

    item_details = repo.view_order(1)[0]
    items_ordered = repo.view_order(1)[1]

    expect(item_details.customer_name).to eq 'Ryan Lai'
    expect(item_details.order_date).to eq '12-07-2001'

    expect(items_ordered.length).to eq 2
    expect(items_ordered.first.item_name).to eq '叉烧包'
    expect(items_ordered.first.order_quantity).to eq '2'
    expect(items_ordered.first.price).to eq '10'
    expect(items_ordered[1].item_name).to eq 'Asam Laksa'
    expect(items_ordered[1].order_quantity).to eq '1'
    expect(items_ordered[1].price).to eq '12'
  end

  it 'returns the date of an order, given the order id' do
    repo = OrderRepository.new

    date = repo.find_date(1)

    expect(date).to eq '12-07-2001'
  end

  it 'returns the date of another order, given the order id' do
    repo = OrderRepository.new

    date = repo.find_date(3)

    expect(date).to eq '04-02-1971'
  end

  it 'creates a new order in the orders table, allowing the user to add one item of specified quantity to the new order' do
    repo = OrderRepository.new

    order = Order.new
    order.customer_name = 'Usagi'
    order.order_date = '12-12-2023'
    
    item_ids = [5]
    item_quantities = [5]

    repo.create(order, item_ids, item_quantities)

    new_order_details = repo.view_order(4)[0]

    expect(order.customer_name).to eq 'Usagi'
    expect(order.order_date).to eq '12-12-2023'

    new_order_item = repo.view_order(4)[1][0]

    expect(new_order_item.item_name).to eq 'Beef Teriyaki Burger'
    expect(new_order_item.order_quantity).to eq '5'

  end

  it 'creates a new order in the orders table, allowing the user to add multiple items of specified quantities to the new order' do
    repo = OrderRepository.new

    order = Order.new
    order.customer_name = 'Usagi'
    order.order_date = '12-12-2023'
    
    item_ids = [5, 4]
    item_quantities = [5, 2]

    repo.create(order, item_ids, item_quantities)

    new_order_details = repo.view_order(4)[0]

    expect(order.customer_name).to eq 'Usagi'
    expect(order.order_date).to eq '12-12-2023'

    new_order_item = repo.view_order(4)[1][1]

    expect(new_order_item.item_name).to eq 'Asam Laksa'
    expect(new_order_item.order_quantity).to eq '2'
    expect(new_order_item.price).to eq '24'

    new_order_item = repo.view_order(4)[1][0]

    expect(new_order_item.item_name).to eq 'Beef Teriyaki Burger'
    expect(new_order_item.order_quantity).to eq '5'
    expect(new_order_item.price).to eq '200'

  end

end