require 'order_repository'

RSpec.describe OrderRepository do
  def reset_shop_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_shop_table
  end

  it "returns list of all orders" do
    repo = OrderRepository.new
    order_list = repo.all_orders
    output = []
    customer_names = [
      "Emma Jones",
      "Benjamin Lee",
      "Sophie Chen",
      "Jack Wilson",
      "Olivia Brown"
    ]

    order_list.each { |order|
      output << order.customer
    }

    expect(output.length).to eq 5
    expect(output).to eq customer_names
  end

  it "returns single order information, without items" do
    repo = OrderRepository.new
    single_order = repo.single_order(2)

    expect(single_order.customer).to eq "Benjamin Lee"
    expect(single_order.date_of_order).to eq "2023-04-03"
  end

  it "returns single order, with items" do
    repo = OrderRepository.new
    single_order = repo.single_order_with_items(2)
    ex_items = [
      "Zenith Smart Watch",
      "ThunderBolt Energy Drink",
      "ScentSation Perfume"]
    expect(single_order.customer).to eq "Benjamin Lee"
    expect(single_order.date_of_order).to eq "2023-04-03"
    expect(single_order.order_items).to eq ex_items
  end
end
