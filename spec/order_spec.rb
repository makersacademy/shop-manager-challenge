require_relative '../lib/order_repo'

def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'store_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe OrderRepository do
  
  before(:each) do 
    reset_orders_table
  end

  it 'returns the list of orders, (added .first method)' do 
    repo = OrderRepository.new 
    orders = repo.all

    expect(orders.length).to eq(2)
    expect(orders.first.id).to eq('1') 
    expect(orders.first.customer_name).to eq ("David")
  end 

 
   it 'returns a single artist and info from id = "1"' do 
   repo = OrderRepository.new 
   order = repo.find(1)
   expect(order.customer_name).to eq('David')
   expect(order.item_ordered).to eq('pizza')
  end 

  it 'creates a new artist' do 
    repo = OrderRepository.new 

      order = Order.new 
      order.customer_name = 'Chantal'
      order.item_ordered = 'Gin'
      order.date_order = 'October 29th'

      repo.create(order) # => nil

      orders = repo.all

      new_order = orders.last
      expect(new_order.customer_name).to eq('Chantal')
      expect(new_order.item_ordered).to eq('Gin')
end 
end