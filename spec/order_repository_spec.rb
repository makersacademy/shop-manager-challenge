require 'order'
require 'order_repository'

def reset_orders_table
    seed_sql = File.read('schema/items_orders_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
    connection.exec(seed_sql)
  end
  
describe OrderRepository do
  before do 
    reset_orders_table
    @terminal_io = double :terminal_io
    @repo = OrderRepository.new(@terminal_io)
  end
  
      
  it 'lists all orders' do

    orders = @repo.list_all_orders

    expect(orders.length).to eq 5

    expect(orders[2].id).to eq '3'
    expect(orders[2].customer_name).to eq 'Monica Geller'
    expect(orders[2].order_date).to eq '1997-10-10'
    expect(orders[2].item_id).to eq '1'

    expect(orders[3].id).to eq '4'
    expect(orders[3].customer_name).to eq 'Ted Moseby'
    expect(orders[3].order_date).to eq '2006-10-10'
    expect(orders[3].item_id).to eq '3'
  end

  it 'creates a new order' do
    
    # Prompt 1
    expect(@terminal_io).to receive(:puts).with('What is the name of the customer?')
    expect(@terminal_io).to receive(:gets).and_return('Samuel Badru') 

    # Prompt 2
    expect(@terminal_io).to receive(:puts).with('What is the order date (YYYY-MM-DD format)?')
    expect(@terminal_io).to receive(:gets).and_return('2023-09-27')

    # Prompt 3
    expect(@terminal_io).to receive(:puts).with('What is the item id for this order?')
    expect(@terminal_io).to receive(:gets).and_return('4')
    
    expect(@terminal_io).to receive(:puts).with('Order successfully created!')
    new_order = @repo.create_new_order

    all_orders = @repo.list_all_orders

    expect(all_orders).to include(have_attributes(customer_name: 'Samuel Badru', order_date: '2023-09-27', item_id: '4'))
  end
end