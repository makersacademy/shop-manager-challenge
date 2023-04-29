require_relative '../lib/order_repository'

RSpec.describe OrderRepository do
  before(:each) do
    reset_stock_table
  end

  it 'returns a list of orders' do
    repo = OrderRepository.new
    orders = repo.list
    expect(orders.first.id).to eq '1'
    expect(orders.first.customer_name).to eq "Mike"
    expect(orders.first.date).to eq "2023-04-28"
    expect(orders.size).to eq 2
  end

  it 'creates an order' do
    repo = OrderRepository.new
    order = double :Order, customer_name: 'Mike', date: '2023-04-28'
    repo.create(order)
    orders = repo.list
    expect(orders.last.customer_name).to eq order.customer_name
    expect(orders.last.date).to eq order.date
  end
end
