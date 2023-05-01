require_relative '../app.rb'

def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

def reset_items_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end


RSpec.describe Application do
  before(:each) do
    reset_orders_table
    reset_items_table
  end

  it 'prints a user menu and prints a list of items' do

    io = double(:io)

    expect(io).to receive(:puts).with(
      "Welcome to the shop management program!
      
      What do you want to do?
        1 = list all shop items
        2 = create a new item
        3 = list all orders
        4 = create a new order"
      ).ordered

    expect(io).to receive(:gets).and_return('1').ordered
    expect(io).to receive(:puts).with("#1 Cookie Dough - Unit price: 2.99 - Quantity: 25").ordered
    expect(io).to receive(:puts).with("#2 Ice Cream - Unit price: 1.99 - Quantity: 50").ordered


    app = Application.new(
      'shop_manager_test',
      io,
      ItemRepository.new, 
      OrderRepository.new
    )

    app.run
    
  end

  it 'prints a user menu and prints a list of orders' do

    io = double(:io)

    expect(io).to receive(:puts).with(
      "Welcome to the shop management program!
      
      What do you want to do?
        1 = list all shop items
        2 = create a new item
        3 = list all orders
        4 = create a new order"
      ).ordered

    expect(io).to receive(:gets).and_return('3').ordered
    expect(io).to receive(:puts).with("Date: 2023-04-27 - Order ID 1 - Customer Name: Caroline - item_id: 1").ordered
    expect(io).to receive(:puts).with("Date: 2023-04-28 - Order ID 2 - Customer Name: Phil - item_id: 2").ordered


    app = Application.new(
      'shop_manager_test',
      io,
      ItemRepository.new, 
      OrderRepository.new
    )

    app.run
    
  end


  it 'prints a user menu and creates a new item' do

    io = double(:io)

    expect(io).to receive(:puts).with(
      "Welcome to the shop management program!
      
      What do you want to do?
        1 = list all shop items
        2 = create a new item
        3 = list all orders
        4 = create a new order"
      ).ordered

    expect(io).to receive(:gets).and_return('2').ordered
    expect(io).to receive(:puts).with("Please enter the new item's name:").ordered
    expect(io).to receive(:gets).and_return('Giant Cookie').ordered
    expect(io).to receive(:puts).with("Please enter the new item's unit price:").ordered
    expect(io).to receive(:gets).and_return('14.99').ordered
    expect(io).to receive(:puts).with("Please enter the new item's quantity:").ordered
    expect(io).to receive(:gets).and_return('5').ordered
    
    app = Application.new(
      'shop_manager_test',
      io,
      ItemRepository.new, 
      OrderRepository.new
    )

    app.run

    item_repository = ItemRepository.new
    last_item = item_repository.all.last
    expect(last_item.id).to eq 3
    expect(last_item.name).to eq 'Giant Cookie'
    expect(last_item.unit_price).to eq 14.99
    expect(last_item.quantity).to eq 5
    
  end

  it 'prints a user menu and creates a new order' do

    io = double(:io)

    expect(io).to receive(:puts).with(
      "Welcome to the shop management program!
      
      What do you want to do?
        1 = list all shop items
        2 = create a new item
        3 = list all orders
        4 = create a new order"
      ).ordered

    expect(io).to receive(:gets).and_return('4').ordered
    expect(io).to receive(:puts).with("Please enter the date (YYYY-MM-DD):").ordered
    expect(io).to receive(:gets).and_return('2023-04-30').ordered
    expect(io).to receive(:puts).with("Please enter the customer's name:").ordered
    expect(io).to receive(:gets).and_return('Pipin').ordered
    expect(io).to receive(:puts).with("Please enter the item ID:").ordered
    expect(io).to receive(:gets).and_return('2').ordered
    
    app = Application.new(
      'shop_manager_test',
      io,
      ItemRepository.new, 
      OrderRepository.new
    )

    app.run

    order_repository = OrderRepository.new
    last_order = order_repository.all.last
    expect(last_order.id).to eq 3
    expect(last_order.customer_name).to eq 'Pipin'
    expect(last_order.date).to eq '2023-04-30'
    expect(last_order.item_id).to eq 2
    
  end

end

