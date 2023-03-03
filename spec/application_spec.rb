require './app.rb'
def initialize
  @database = 'shop_manager_test'
end

def reset_seeds_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: @database })
  connection.exec(seed_sql)
end

RSpec.describe Application do
  before(:each) do 
    reset_seeds_table
    let(:order_repo) { double("OrdersRepository")}
    let(:item_repo) { double("ItemsRepository")}
    let(:io) { double('io')}
    let(:app) { Application.new(@database, io, order_repo, item_repo) }
    expect(io).to receive(:puts).with("Welcome to the shop management program")
    expect(io).to receive(:puts).with("What do you want to do?")
    expect(io).to receive(:puts).with("1 = list all shop items")
    expect(io).to receive(:puts).with("2 = create a new item")
    expect(io).to receive(:puts).with("3 = list all shop orders")
    expect(io).to receive(:puts).with("4 = create a new  order")
  end
 
  it "gets a list of shop items when user selelects option 1" do
    item1 = instance_double("Item", id: 1, item_name: "Apples", price: "2.05",
      quantity: "5")
    item2 = instance_double("Item", id: 2, item_name: "Pears", price: "5.02",
      quantity: "3")
    allow(item_repo).to receive(:all).and_return([item1, item2])
    expect(app.list_all_items[0]).to eq ("1 Apples - Unit Price: 2.05 - Quantity: 5")
  end

end