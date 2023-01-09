require "order_repository"

describe OrderRepository do
  
  before(:all) do
    @repo = OrderRepository.new
    @order1 = Order.new([1, 'John', '2022-06-20', 1])
    @order2 = Order.new([2, 'Grace', '2023-01-01', 2])
    @order3 = Order.new([3, 'Baz', '2021-07-29', 3])
  end

  after(:each) do
    reset_query = File.read("spec/data_seeds.sql")
    connection = PG.connect({ host: '127.0.0.1', 
    dbname: "shop_manager_test" })
    connection.exec(reset_query)
  end

  it "#all returns array of order objects for all orders in database" do
    expect(@repo.all).to eq [@order1, @order2, @order3]
  end

  it "#create takes order instance and inserts into database" do
    new_order = Order.new([4, "Jeff", '2020-01-01', 3])
    @repo.create(new_order)
    expect(@repo.all).to eq [@order1, @order2, @order3, new_order]
  end

end
