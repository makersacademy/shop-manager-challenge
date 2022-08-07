require 'order_repo'

def reset_tables
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_tables
  end

  it "gets all orders" do
    repo = OrderRepository.new
    orders = repo.all
    
    expect(orders.length).to eq 2
    
    expect(orders[0].id).to eq '1'
    expect(orders[0].customer_name).to eq 'Frank'
    expect(orders[0].date_placed).to eq '04-Jan-2021'
    
    expect(orders[1].id).to eq '2'
    expect(orders[1].customer_name).to eq 'Benny'
    expect(orders[1].date_placed).to eq '05-Aug-2022'  
  end

  it "finds an order" do
    repo = OrderRepository.new
    order = repo.find_order(1)
    
    expect(order.id).to eq '1'
    expect(order.customer_name).to eq 'Frank'
    expect(order.date_placed).to eq '04-Jan-2021'  
  end

  it "finds an order with items" do
    repo = OrderRepository.new
    order = repo.order_with_items(1)
    
    expect(order.id).to eq '1'
    expect(order.customer_name).to eq 'Frank'
    expect(order.date_placed).to eq '04-Jan-2021'
    
    expect(order.items[0].name).to eq 'Hoover'
    expect(order.items[0].unit_price).to eq '100'
    expect(order.items[0].qty).to eq '2'
    
    expect(order.items[1].name).to eq 'Washing Machine'
    expect(order.items[1].unit_price).to eq '400'
    expect(order.items[1].qty).to eq '1'
  end

  it "creates an order" do
    order_repo = OrderRepository.new
    item_repo = ItemRepository.new
    
    order = Order.new
    order.customer_name = 'Mary'
    order.date_placed = '07-Aug-2022'
    item = item_repo.find_item(4)
    item.qty = 1
    order.items << item
    item = item_repo.find_item(5)
    item.qty = 2
    order.items << item

    order_repo.create(order)
    
    orders = order_repo.all
    expect(orders.length).to eq 3
    
    expect(orders[0].id).to eq '1'
    expect(orders[0].customer_name).to eq 'Frank'
    expect(orders[0].date_placed).to eq '04-Jan-2021'
    
    expect(orders[2].id).to eq '3'
    expect(orders[2].customer_name).to eq 'Mary'
    expect(orders[2].date_placed).to eq '07-Aug-2022'
    
    mary_order = order_repo.order_with_items(3)
    expect(mary_order.items[-1].name).to eq 'Fridge'
    expect(mary_order.items[-1].unit_price).to eq '199'
    expect(mary_order.items[-1].qty).to eq '2'
    
    expect(item_repo.find_item(4).qty).to eq '43'
  end

  it "updates an order" do
    repo = OrderRepository.new

    order = Order.new
    order.customer_name = 'Frank'
    order.date_placed = '06-Aug-2022'
    
    repo.update(1, order)
    orders = repo.all.sort_by { |order| order.id.to_i }
    
    expect(orders.length).to eq 2
    
    expect(orders[0].id).to eq '1'
    expect(orders[0].customer_name).to eq 'Frank'
    expect(orders[0].date_placed).to eq '06-Aug-2022'
    
    expect(orders[1].id).to eq '2'
    expect(orders[1].customer_name).to eq 'Benny'
    expect(orders[1].date_placed).to eq '05-Aug-2022'
  end
end
