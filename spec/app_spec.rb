require_relative '../app'

def test_introduction(io)
  expect(io).to receive(:puts).with "Welcome to the shop management program!"
  expect(io).to receive(:puts).with ""
  expect(io).to receive(:puts).with "What do you want to do?"
  expect(io).to receive(:puts).with "  1 = list all shop items"
  expect(io).to receive(:puts).with "  2 = create a new item"
  expect(io).to receive(:puts).with "  3 = list all orders"
  expect(io).to receive(:puts).with "  4 = create a new order"
end

RSpec.describe Application do
  it 'prints all the items' do
    item1 = double(:item, id: 1, name: "Balloon", unit_price: 2.99, quantity: 5)
    item2 = double(:item, id: 2, name: "Animal", unit_price: 3, quantity: 1)
    item_repo = double(:item_repository, all: [item1, item2])
    order_repo = double(:order_repository)
    item_class = double(:item_class)
    order_class = double(:order_class)

    io = double(:io)
    test_introduction(io)

    expect(io).to receive(:gets).and_return "1"
    expect(io).to receive(:puts).with ""
    expect(io).to receive(:puts).with "Here's a list of all shop items:"
    expect(io).to receive(:puts).with ""
    expect(io).to receive(:puts).with " #1 Balloon - Unit price: 2.99 - Quantity: 5"
    expect(io).to receive(:puts).with " #2 Animal - Unit price: 3 - Quantity: 1"
    
    app = Application.new(
      'shop_manager_test', io, 
      item_repo, order_repo, 
      item_class, order_class
    )
    app.run
  end

  it 'creates a new item' do
    order_repo = double(:order_repository)
    item_repo = double(:item_repository)
    item = double(:item)
    expect(item).to receive(:name=).with("Chocolate")
    expect(item).to receive(:unit_price=).with(1.99)
    expect(item).to receive(:quantity=).with(3)

    item_class = double(:item_class, new: item)
    order_class = double(:order_class)

    io = double(:io)
    test_introduction(io)

    expect(io).to receive(:gets).and_return "2"
    expect(io).to receive(:puts).with ""
    expect(io).to receive(:puts).with "Item name:"
    expect(io).to receive(:gets).and_return "Chocolate"
    expect(io).to receive(:puts).with "Item price:"
    expect(io).to receive(:gets).and_return "1.99"
    expect(io).to receive(:puts).with "Item quantity:"
    expect(io).to receive(:gets).and_return "3"

    expect(item_repo).to receive(:create).with(item)

    app = Application.new(
      'shop_manager_test', io, 
      item_repo, order_repo, 
      item_class, order_class
    )
    app.run
  end

  it 'prints all the orders' do
    order = double(:order, id: 1, customer_name: "Lucy", date_placed: '2023-01-01', item_name: "Bicycle")
    item_repo = double(:item_repository)
    order_repo = double(:order_repository, all: [order])
    item_class = double(:item_class)
    order_class = double(:order_class)

    io = double(:io)
    test_introduction(io)

    expect(io).to receive(:gets).and_return "3"
    expect(io).to receive(:puts).with ""
    expect(io).to receive(:puts).with "Here's a list of all the orders:"
    expect(io).to receive(:puts).with ""
    expect(io).to receive(:puts).with " #1 Lucy placed an order on 2023-01-01 for a Bicycle"

    app = Application.new(
      'shop_manager_test', io, 
      item_repo, order_repo, 
      item_class, order_class
    )
    app.run
  end
end