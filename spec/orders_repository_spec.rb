require 'orders_repository'

RSpec.describe OrdersRepository do

  def reset_orders_table
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  
    before(:each) do
      reset_orders_table
    end

  it "gets all the orders" do
    repo = OrdersRepository.new
    orders = repo.all
    expect(orders.length).to eq 5
    expect(orders[0].id).to eq '1'
    expect(orders[0].name).to eq 'Lamar'
    expect(orders[0].date).to eq '2022-11-01'
    expect(orders[0].item_id).to eq '1'
  end

  it "find a specific order" do
    repo = OrdersRepository.new
    orders = repo.find(1)
    expect(orders.name).to eq 'Lamar'
    expect(orders.date).to eq '2022-11-01'
    expect(orders.item_id).to eq '1'
  end 

  it "creates a new order" do
    repo = OrdersRepository.new
    new_order = Order.new
    new_order.name = 'Fields'
    new_order.date = '2022-11-05'
    new_order.item_id = '5'

    repo.create(new_order)
    orders = repo.all
    last_order = orders.last

    expect(last_order.name).to eq 'Fields'
    expect(last_order.date).to eq '2022-11-05'
    expect(last_order.item_id).to eq '5'
  end 
end 