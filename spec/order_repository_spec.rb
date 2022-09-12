require '../lib/order_repository'
require '../lib/database_connection'

DatabaseConnection.connect('shop_manager_library')

def reset_orders_table
  seed_sql = File.read('../spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_library' })
  connection.exec(seed_sql)
end

RSpec.describe OrderRepository do
    before(:each) do 
        reset_orders_table
      end
  it "constructs" do
    io = double(:io)
    repo = OrderRepository.new(io)
    result = repo.all
    expect(result.length).to eq 11
  end

  it "creates a new order" do
    io = double(:io)
    
    expect(io).to receive(:puts).with("What is the customer name?")
    expect(io).to receive(:gets).and_return("James Leafblower")
    expect(io).to receive(:puts).with("What is the item id?")
    expect(io).to receive(:gets).and_return("2")
    expect(io).to receive(:puts).with("Order created and quantity updated")
    

    repo = OrderRepository.new(io)
    repo.create
    result = repo.all
    expect(result.length).to eq 12
    expect(result[5].customer_name).to eq 'Djembe Djones'
  end

  it "creates a new order" do
    io = double(:io)
    
    expect(io).to receive(:puts).with("What is the customer name?")
    expect(io).to receive(:gets).and_return('beanbag')
    expect(io).to receive(:puts).with("What is the item id?")
    expect(io).to receive(:gets).and_return("1")
    expect(io).to receive(:puts).with("Order created and quantity updated")
    

    repo = OrderRepository.new(io)
    repo.create
    result = repo.all
    expect(result.length).to eq 12
    expect(result[11].customer_name).to eq 'Harponius Leafblower'
  end
end