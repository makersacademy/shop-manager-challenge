require 'menu'
require 'menu_result'


RSpec.describe MenuResult do
  def reset_orders_table
    seed_sql = File.read('spec/test_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  before(:each) do 
    reset_orders_table
  end

  it 'prints all the items' do
    io = double :io
    expect(io).to receive(:puts).with("Here's a list of all shop items:")
    expect(io).to receive(:puts).with('#1: Carbonara, Unit price: 10, Quantity: 2')
    expect(io).to receive(:puts).with('#2: Milk, Unit price: 2, Quantity: 3')

    menu = MenuResult.new(io)
    menu.list_items
  end

  it 'prints all the orders' do
    io = double :io
    expect(io).to receive(:puts).with("Here's a list of all orders:")
    expect(io).to receive(:puts).with('#1: 2023-02-06, Customer: Paolo, Item id: 1')
    expect(io).to receive(:puts).with('#2: 2023-02-21, Customer: Anna, Item id: 2')

    menu = MenuResult.new(io)
    menu.list_orders
  end
end