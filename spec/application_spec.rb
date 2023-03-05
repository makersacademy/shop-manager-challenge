require './lib/app.rb'

def reset_seeds_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe Application do
  let(:order_repo) { double("OrdersRepository")}
  let(:item_repo) { double("ItemsRepository")}
  let(:io) { double('io')}
  let(:app) { Application.new('shop_manager_test', io, item_repo, order_repo) }
  before(:each) do 
    reset_seeds_table
  end
 
  it "gets a list of shop items when user selects option 1" do
    item1 = instance_double("Item", id: 1, item_name: "Apples", price: "2.05", quantity: "5")
    item2 = instance_double("Item", id: 2, item_name: "Pears", price: "5.02", quantity: "3")
    allow(item_repo).to receive(:all).and_return([item1, item2])
    allow(io).to receive(:puts)
    expect(io).to receive(:gets).and_return("1\n") # stub gets method to return "1\n"
    expect(io).to receive(:puts).with("1 - Apples - 2.05 - 5")
    expect(io).to receive(:puts).with("2 - Pears - 5.02 - 3")
    app.choose_option
  end

  it "creates a new shop item when user selects option 2" do
    allow(io).to receive(:puts)
    expect(io).to receive(:gets).and_return("2\n") # stub gets method to return "1\n"
    expect(io).to receive(:gets).and_return("Oranges\n", "2.45\n", "2\n")
    expect(item_repo).to receive(:create).with(instance_of(Items))
    expect(io).to receive(:puts).with("Item added")
    app.choose_option
  end

 it "gets a list of shop orders when user selects option 3" do
    order1 = instance_double("Order", id: 1, customer_name: "James Pates", order_date: "2023-03-02", item_id: "1")
    order2 = instance_double("Order", id: 2, customer_name: "Ann Pates", order_date: "2023-03-01", item_id: "2")
    allow(order_repo).to receive(:all).and_return([order1, order2])
    allow(io).to receive(:puts)
    expect(io).to receive(:gets).and_return("3\n") # stub gets method to return "1\n"
    expect(io).to receive(:puts).with("1 - James Pates - 2023-03-02 - 1")
    expect(io).to receive(:puts).with("2 - Ann Pates - 2023-03-01 - 2")
    app.choose_option
  end
end