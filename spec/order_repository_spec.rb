require "order_repository"

def reset_tables
  seed_sql = File.read('spec/seeds_all.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do
    reset_tables
  end

  it "Returns all orders" do
    repo = OrderRepository.new
    results = repo.all

    expect(results.length).to eq 3
    expect(results[0].id).to eq 1
    expect(results[0].customer_name).to eq "Alex Hoggett"
    expect(results[0].order_date).to eq "12th Dec 2021"
    expect(results[0].item_id).to eq 2

    expect(results[1].id).to eq 2
    expect(results[1].customer_name).to eq "Shaun Flood"
    expect(results[1].order_date).to eq "22th Feb 2021"
    expect(results[1].item_id).to eq 1
  end

  it "Adds a new order to the table" do
    repo = OrderRepository.new

    order = Order.new
    order.customer_name = "John Doe"
    order.order_date = "19th July 2021"
    order.item_id = 4

    repo.create(order)
    orders = repo.all

    expect(
      orders.any? { |o| o.customer_name == order.customer_name && o.order_date == order.order_date }
    ).to eq true
  end

end