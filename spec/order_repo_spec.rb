require 'order_repo'

RSpec.describe OrderRepo do
  before(:each) do
    reset_tables
  end

  it "returns a list of all orders with correct related items" do
    repo = OrderRepo.new

    orders = repo.all

    expect(orders.length).to eq 3
    expect(orders.first.customer_name).to eq 'Barney'
    expect(orders.first.order_date).to eq '2023-01-01'
    expect(orders.first.items.length).to eq 2
    
    expect(orders.last.customer_name).to eq 'Michael'
    expect(orders.last.order_date).to eq '2023-04-28'
  end

  it "can create a new order" do
    repo = OrderRepo.new

    order = double :order, customer_name: 'fake_name', order_date: '2023-04-28'

    repo.create_order(order)
    orders = repo.all

    expect(orders.length).to eq 4
    expect(orders.last.customer_name).to eq 'fake_name'
    expect(orders.last.order_date).to eq '2023-04-28'
  end

  it "can fetch items associated with an order" do
    repo = OrderRepo.new

    result = repo.fetch_items(1)
    expect(result.length).to eq 2
    expect(result.first.name).to eq 'Star Wars Jedi: Survivor'
    expect(result.last.name).to eq 'Dead Space'
  end

  it "can assign an order to an item" do
    repo = OrderRepo.new

    repo.add_item_to_order(4, 1)
    result = repo.fetch_items(1)
    expect(result.length).to eq 3
    expect(result.last.name).to eq 'Metroid Prime'
  end
end
