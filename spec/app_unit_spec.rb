require_relative '../app'

RSpec.describe Application do
 
  def reset_artists_table
    seed_sql = File.read('spec/seed_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
 
  before(:each) do
    reset_artists_table
  end

  it 'Tests list(items) method' do
    io = double :io
    expect(io).to receive(:puts).with "Here's a list of all shop items:"
    expect(io).to receive(:puts).with "\n"
    expect(io).to receive(:puts).with '#1 cheese - Unit price: 2 - Quantity: 5'
    expect(io).to receive(:puts).with '#2 hot crossed buns - Unit price: 3 - Quantity: 10'
    expect(io).to receive(:puts).with '#3 sausage - Unit price: 1 - Quantity: 5'
    run_app = Application.new('shop_manager_test', io, 'lib/item_repository', 'lib/order_repository')
    run_app.list("items")
  end
  
  it 'Tests list(orders) method' do
    io = double :io
    expect(io).to receive(:puts).with 'Current unfulfilled orders'
    expect(io).to receive(:puts).with "\n"
    expect(io).to receive(:puts).with '#1 Joe - order placed: sept'
    expect(io).to receive(:puts).with '#2 Dave - order placed: oct'
    run_app = Application.new('shop_manager_test', io, 'lib/item_repository', 'lib/order_repository')
    run_app.list('orders')
  end

# I tested the list function first, when I built the run function, I have to
# comment out the case input choice as it then runs the list method, couldn't figure
# how to run the test withou it failing
  it 'tests run method and list(items)' do 
    io = double :io
    expect(io).to receive(:puts).with "Welcome to the shop management program!"
    expect(io).to receive(:puts).with "\n"
    expect(io).to receive(:puts).with 'What do you want to do?'
    expect(io).to receive(:puts).with '1 = list all shop items'
    expect(io).to receive(:puts).with '2 = create a new item'
    expect(io).to receive(:puts).with '3 = list all orders'
    expect(io).to receive(:puts).with '4 = create a new order'
    expect(io).to receive(:gets).and_return '1'
    run_app = Application.new('shop_manager_test', io, 'lib/item_repository', 'lib/order_repository')
    run_app.run
  end

  it 'tests create(new_item) method' do
    io = double :io
    expect(io).to receive(:puts).with 'Please enter name of new item'
    expect(io).to receive(:gets).and_return 'irn bru'
    expect(io).to receive(:puts).with 'Please enter unit price'
    expect(io).to receive(:gets).and_return '1'
    expect(io).to receive(:puts).with 'Please enter quantity'
    expect(io).to receive(:gets).and_return '10'
    expect(io).to receive(:puts).with 'Please enter order number'
    expect(io).to receive(:gets).and_return '1'
    expect(io).to receive(:puts).with 'irn bru - Unit price: 1 - Quantity: 10 - added to items'
    run_app = Application.new('shop_manager_test', io, 'lib/item_repository', 'lib/order_repository')
    run_app.create('item')
  end

  it 'tests create(new_order) method' do
    io = double :io
    expect(io).to receive(:puts).with 'Please enter customer_name for new order'
    expect(io).to receive(:gets).and_return 'Bob'
    expect(io).to receive(:puts).with 'Please enter order date as month'
    expect(io).to receive(:gets).and_return 'sept'
    expect(io).to receive(:puts).with 'Bob - order created: sept'
    run_app = Application.new('shop_manager_test', io, 'lib/item_repository', 'lib/order_repository')
    run_app.create('order')
  end
 
end


 

 
#  # create and populate the objects - for integration 
#  repo = ItemRepository.new
#  item = Item.new
#  item.item_name = i_name
#  item.price = i_price
#  item.quantity = i_quantity
#  item.order_id = i_order
#  # check it's worked
#  items = repo.all
#  items.length # => 4
#  items[3].item_name  # => i_name
#  items[3].price # =>i_price
#  items[3].quantity # =>i_quantity
#  items[3].order_id # =>i_order
 
#  # test create(new_order) method
 

#  # create and populate the objects - for integration 
#  repo = OrderRepository.new
#  order = Order.new
#  order.customer_name = o_name
#  order.date = o_date
#  # check it's worked
#  orders = repo.all
#  orders.length # => 3
#  orders[2].customer_name = o_name
#  orders[2].date = o_date
  