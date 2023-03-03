require './lib/app.rb'

def initialize
  @database = 'shop_manager_test'
end

def reset_seeds_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: @database })
  connection.exec(seed_sql)
end

RSpec.describe Application do
  let(:order_repo) { double("OrdersRepository")}
  let(:item_repo) { double("ItemsRepository")}
  let(:io) { double('io')}
  let(:app) { Application.new(@database, io, item_repo, order_repo) }
  before(:each) do 
    reset_seeds_table
  end
 
  it "gets a list of shop items when user selelects option 1" do
    item1 = instance_double("Item", id: 1, item_name: "Apples", price: "2.05", quantity: "5")
    item2 = instance_double("Item", id: 2, item_name: "Pears", price: "5.02", quantity: "3")
    allow(item_repo).to receive(:all).and_return([item1, item2])
    allow(io).to receive(:puts)
    expect(io).to receive(:gets).and_return("1\n") # stub gets method to return "1\n"
    expect(io).to receive(:puts).with("1 - Apples - 2.05 - 5")
    expect(io).to receive(:puts).with("2 - Pears - 5.02 - 3")
    app.choose_option
  end

end