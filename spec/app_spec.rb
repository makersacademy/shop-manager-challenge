require_relative "../app"

def reset_app_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'orders_test' })
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do 
    reset_app_table
  end

  it "return a list of all items" do
    io = double :io
    item_repo = double :item_repository
    order_repo = double :order_repository
    first = double :item, name: 'Days', unit_price: '5', quantity: 3, id: 1
    second = double :item, name: 'Months', unit_price: '10', quantity: 6, id: 2
    third = double :item, name: 'Years', unit_price: '15', quantity: 9, id: 3
    expect(io).to receive(:puts).with("Welcome to the Shop Manager Program").ordered
    expect(io).to receive(:puts).with("What do you want to do?").ordered
    expect(io).to receive(:puts).with("1. List all shop items").ordered
    expect(io).to receive(:puts).with("2. Create a new item").ordered
    expect(io).to receive(:puts).with("3. List all orders").ordered
    expect(io).to receive(:puts).with("4. Create a new order").ordered
    expect(io).to receive(:gets).and_return("1").ordered
    expect(io).to receive(:puts).with("Here is the list of all items:").ordered
    expect(item_repo).to receive(:all).and_return [first, second, third]
    app = Application.new('orders_test', io, item_repo, order_repo)
    app.run
  end

  it "return a list of all orders" do
    io = double :io
    item_repo = double :item_repository
    order_repo = double :order_repository
    first = double :order, id: 1, customer_name: 'Tate', date: '2022-02-02'
    second = double :order, id: 2, customer_name: 'Late', date: '2022-03-03'
    third = double :order, id: 3, customer_name: 'Bait', date: '2022-04-04'
    expect(io).to receive(:puts).with("Welcome to the Shop Manager Program").ordered
    expect(io).to receive(:puts).with("What do you want to do?").ordered
    expect(io).to receive(:puts).with("1. List all shop items").ordered
    expect(io).to receive(:puts).with("2. Create a new item").ordered
    expect(io).to receive(:puts).with("3. List all orders").ordered
    expect(io).to receive(:puts).with("4. Create a new order").ordered
    expect(io).to receive(:gets).and_return("3")
    expect(io).to receive(:puts).with("Here is the list of all orders:").ordered
    expect(order_repo).to receive(:all).and_return [first, second, third]
    app = Application.new('orders_test', io, item_repo, order_repo)
    app.run
  end

  it "given an invlaid input" do
    io = double :io
    item_repo = double :item_repository
    order_repo = double :order_repository
    expect(io).to receive(:puts).with("Welcome to the Shop Manager Program").ordered
    expect(io).to receive(:puts).with("What do you want to do?").ordered
    expect(io).to receive(:puts).with("1. List all shop items").ordered
    expect(io).to receive(:puts).with("2. Create a new item").ordered
    expect(io).to receive(:puts).with("3. List all orders").ordered
    expect(io).to receive(:puts).with("4. Create a new order").ordered
    expect(io).to receive(:gets).and_return("a")
    app = Application.new('orders_test', io, item_repo, order_repo)
    expect { app.run }.to raise_error "Invalid Input"
  end
end