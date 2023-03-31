require 'order_repository'
require 'order'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test'})
  connection.exec(seed_sql)
end

describe OrderRepository do
  before :each do
    reset_tables
  end

  it "returns all orders" do
    repo = OrderRepository.new
    result_set = repo.all
    expect(result_set.length).to eq 2
    expect(result_set.first.customer_name).to eq "Uncle Bob"
    expect(result_set.first.date).to eq '2022-09-05'
    expect(result_set.last.id).to eq 2
    expect(result_set.last.date).to eq '2023-02-22'
  end

  it "inserts an item into the DB table with #create" do
    repo = OrderRepository.new
    order = Order.new
    order.customer_name, order.date = "Matz", '2023-01-01'
    expect(repo.create(order)).to eq nil
    result_set = repo.all
    expect(result_set.length).to eq 3
    expect(result_set.first.customer_name).to eq "Uncle Bob"
    expect(result_set.last.customer_name).to eq "Matz"
    expect(result_set.last.date).to eq "2023-01-01"
    expect(result_set[1].date).to eq "2023-02-22"
  end

  xit "returns an array of formatted strings" do
    repo = ItemRepository.new
    result = repo.print_all
    expect(result).to be_a Array
    expect(result.length).to eq 3
    expect(result.first).to eq " #1 MacBookPro - Unit price: 999.99 - Quantity: 50"
    expect(result.last).to eq " # Charger - Unit price: 50.49 - Quantity: 25"
  end
end