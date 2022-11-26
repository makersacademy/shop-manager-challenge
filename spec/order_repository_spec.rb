require "order_repository"

RSpec.describe OrderRepository do

  def reset_table
    seed_sql = File.read('spec/seeds.sql')

    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_challenge' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_table
  end


  it 'lists all the orders in the order repository' do
    repo = OrderRepository.new
    # make a list of all orders
    orders_list = repo.all
    # check the array's length
    expect(orders_list.length).to eq 3
    # check th content inside the array
    expect(orders_list.first.customer_name).to eq 'Ben W'
    expect(orders_list.first.date).to eq '1999-01-08 00:00:00'
    expect(orders_list.last.customer_name).to eq 'Bill Z'
    expect(orders_list.last.date).to eq '2034-07-22 00:00:00'
  end

  it 'creates a new order and add it to the order repository' do
    repo = OrderRepository.new
    orders_list = repo.all
    expect(orders_list.length).to eq 3
    expect(orders_list.last.customer_name).to eq 'Bill Z'
    # create a new order filling all the fields
    new_order = Order.new
    new_order.customer_name = 'Fred E'
    new_order.date = '1732-05-09 20:00:20'
    # the create method add the order to the list
    # it also automatically generates a new id for this order
    repo.create(new_order)
    updated_orders_list = repo.all
    # the orders list length is now longer by one element in the array
    expect(updated_orders_list.length).to eq 4
    # the new order is appended to the list
    # we can use .last to check the details on the order we just created
    last_order = updated_orders_list.last
    expect(last_order.customer_name).to eq 'Fred E'
    expect(last_order.date).to eq '1732-05-09 20:00:20'

    expect(updated_orders_list).to include(
      have_attributes(
      customer_name: new_order.customer_name,
      date: new_order.date
      )
    )
  end

end
