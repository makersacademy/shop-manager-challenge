require 'order_repository'

describe OrderRepository do
  def reset_orders_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'items_orders_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_orders_table
  end

  it "returns all order record" do
    repository = OrderRepository.new
    all_orders = repository.all_order
  
    expect(all_orders.first.customer_name).to eq ('Tinky-Winky')
    expect(all_orders.first.date_ordered).to eq ('2022-09-28')
    expect(all_orders.first.item_name).to eq ('Tower Air Fryer')
  end

  it "creates an order record" do
    repository = OrderRepository.new

    order = Order.new
    order.customer_name = 'Olaf'
    order.date_ordered = '2022-09-30'
    order.items_orders.item_id = 1
    order.items_orders.order_id = 3
    
    repository.create(order) 
  
    all_orders = repository.all
    expect(all_items).to include(
      have_attributes(
        customer_name: 'Olaf',
        date_ordered: '2022-09-30',
        item_name: 'Tower Air Fryer'
      )
    ) 
  end
end