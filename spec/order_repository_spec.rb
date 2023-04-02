require 'order_repository'
require 'item'

describe OrderRepository do 
  def reset_all_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  def reset_empty_table
    seed_sql = File.read('spec/seeds_empty.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_all_table()
  end

  it "should return data placed and name" do 
    order_repo = OrderRepository.new 
    result = order_repo.all 
    order_1 = Order.new(1,'2020-05-30', 'John Brown')
    order_2 = Order.new(2,'2020-04-20', 'Anne Smith')

    expect(result).to eq [order_1, order_2]
  end

  it "should return an empty array" do 
    reset_empty_table()
    order_repo = OrderRepository.new 
    result = order_repo.all 
  
    expect(result).to eq []

  end

  it "should create a new order" do 
    order_repo = OrderRepository.new 

    order_3 = Order.new(3,'2020-06-20', 'Carol Smith')

    order_repo.create(order_3)
    result = order_repo.all[-1]

    expect(result.customer_name).to eq 'Carol Smith'
    expect(result.date_placed).to eq '2020-06-20'

  end

  it "should create order with items" do 

    order_repo = OrderRepository.new 
    item_1 = Item.new(1,'Ray-Ban Sunglasses', 80.00, 100)
    item_2 = Item.new(2,'Tefal set pans', 150.00, 9)

    order_3 = Order.new(nil, '2020-06-20', 'Carol Smith')
    order_3.items << item_1
    order_3.items << item_2

    order_repo.create_with_items(order_3)

    result = order_repo.find_with_items(3)

    expect(result.items[0].id).to eq 1
    expect(result.items[1].id).to eq 2
  end

end