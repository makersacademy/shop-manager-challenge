require "orders_repository"

def reset_orders_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrdersRepository do
  before(:each) do 
    reset_orders_table
  end

  # Get all Orders
  it "Gets all orders" do
    repo = OrdersRepository.new

    orders = repo.all

    orders.length # =>  2

    expect(orders[0].id).to eq (1)
    expect(orders[0].customer_name).to eq ('james pates')
    expect(orders[0].order_date).to eq ('2023-03-03')
    expect(orders[0].item_id).to eq ('1')

    expect(orders[1].id).to eq (1)
    expect(orders[1].customer_name).to eq ('james pates')
    expect(orders[1].order_date).to eq ('2023-03-01')
    expect(orders[1].item_id).to eq ('1')
  end
end