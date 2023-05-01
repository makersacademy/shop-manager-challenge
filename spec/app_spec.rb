require_relative '../app'

def test_introduction(io)
  expect(io).to receive(:puts).with "Welcome to the shop management program!"
  expect(io).to receive(:puts).with ""
  expect(io).to receive(:puts).with "What do you want to do?"
  expect(io).to receive(:puts).with "  1 = list all shop items"
  expect(io).to receive(:puts).with "  2 = create a new item"
  expect(io).to receive(:puts).with "  3 = list all orders"
  expect(io).to receive(:puts).with "  4 = create a new order"
  expect(io).to receive(:puts).with "  5 = update stock of an item"
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
    expect(io).to receive(:puts).with " #1 Balloon - UP: 2.99 - Q: 5"
    expect(io).to receive(:puts).with " #2 Animal - UP: 3 - Q: 1"
    
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
    item_class = double(:item_class)
    order_class = double(:order_class)

    expect(item_class).to receive(:name=).with("Chocolate")
    expect(item_class).to receive(:unit_price=).with(1.99)
    expect(item_class).to receive(:quantity=).with(3)

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

    expect(item_repo).to receive(:create).with(item_class)
    expect(io).to receive(:puts).with "Item successfully added"

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
    expect(io).to receive(:puts).with " #1 Lucy - Date: 2023-01-01 - Item: Bicycle"

    app = Application.new(
      'shop_manager_test', io, 
      item_repo, order_repo, 
      item_class, order_class
    )
    app.run
  end

  context 'when adding orders' do
    it 'creates a new order' do
      order_repo = double(:order_repository)
      item_repo = double(:item_repository)
      order_class = double(:order_class)
      item_class = double(:item_class, quantity: 20)

      expect(order_class).to receive(:customer_name=).with("Jane")
      expect(order_class).to receive(:date_placed=).with('2023-04-30')
      expect(order_class).to receive(:item_id=).with(1)
      expect(order_class).to receive(:item_id).and_return(1)
      expect(item_repo).to receive(:find).with(1).and_return(item_class)

      io = double(:io)
      test_introduction(io)

      expect(io).to receive(:gets).and_return "4"
      expect(io).to receive(:puts).with ""
      expect(io).to receive(:puts).with "Customer's name:"
      expect(io).to receive(:gets).and_return "Jane"
      expect(io).to receive(:puts).with "Date placed (YYYY-MM-DD):"
      expect(io).to receive(:gets).and_return '2023-04-30'
      expect(io).to receive(:puts).with "Item id:"
      expect(io).to receive(:gets).and_return "1"

      expect(order_repo).to receive(:create).with(order_class)
      expect(io).to receive(:puts).with "Order successfully added"

      app = Application.new(
        'shop_manager_test', io, 
        item_repo, order_repo, 
        item_class, order_class
      )
      app.run
    end

    it 'fails when creating an order for out of stock item' do
      order_repo = double(:order_repository)
      item_repo = double(:item_repository)
      order_class = double(:order_class)
      item_class = double(:item_class, quantity: 0)

      expect(order_class).to receive(:customer_name=).with("Jane")
      expect(order_class).to receive(:date_placed=).with('2023-04-30')
      expect(order_class).to receive(:item_id=).with(1)
      expect(order_class).to receive(:item_id).and_return(1)

      expect(item_repo).to receive(:find).with(1).and_return(item_class)

      io = double(:io)
      test_introduction(io)

      expect(io).to receive(:gets).and_return "4"
      expect(io).to receive(:puts).with ""
      expect(io).to receive(:puts).with "Customer's name:"
      expect(io).to receive(:gets).and_return "Jane"
      expect(io).to receive(:puts).with "Date placed (YYYY-MM-DD):"
      expect(io).to receive(:gets).and_return '2023-04-30'
      expect(io).to receive(:puts).with "Item id:"
      expect(io).to receive(:gets).and_return "1"

      app = Application.new(
        'shop_manager_test', io, 
        item_repo, order_repo, 
        item_class, order_class
      )

      expect { app.run }.to raise_error "Sorry, none in stock!"
    end
  end

  context 'when updating the stock of an item' do
    it 'runs update_quantity' do
      item1 = double(:item, id: 1, name: "Balloon", quantity: 5)
      order_repo = double(:order_repository)
      item_repo = double(:item_repository, all: [item1])
      order_class = double(:order_class)
      item_class = double(:item_class)

      io = double(:io)
      test_introduction(io)

      expect(io).to receive(:gets).and_return "5"
      expect(io).to receive(:puts).with ""
      expect(io).to receive(:puts).with "Enter the item ID:"
      expect(io).to receive(:puts).with " #1: Balloon, 5"
      expect(io).to receive(:gets).and_return "1"
      expect(io).to receive(:puts).with ""
      expect(io).to receive(:puts).with "Enter the quantity added (or minus for removed):"
      expect(io).to receive(:gets).and_return "20"

      expect(item_repo).to receive(:update_quantity).with(1, 20)
      expect(io).to receive(:puts).with ""
      expect(io).to receive(:puts).with "Stock updated successfully"

      app = Application.new(
        'shop_manager_test', io, 
        item_repo, order_repo, 
        item_class, order_class
      )
      app.run
    end
  end
end
