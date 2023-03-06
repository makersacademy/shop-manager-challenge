require_relative '../app'

RSpec.describe do
  def reset_items_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  def reset_orders_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_items_table
    reset_orders_table

    @io = double :io
    expect(@io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(@io).to receive(:puts).with("What do you want to do?").ordered
    expect(@io).to receive(:puts).with(" 1 - list all shop items").ordered
    expect(@io).to receive(:puts).with(" 2 - create a new item").ordered
    expect(@io).to receive(:puts).with(" 3 - list all orders").ordered
    expect(@io).to receive(:puts).with(" 4 - create a new order").ordered
  end

  it 'prints all items' do
    expect(@io).to receive(:gets).and_return("1").ordered
    expect(@io).to receive(:puts).with("here is the list of all shop items:").ordered
    expect(@io).to receive(:puts).with("#1 - Repo Chocolate - Unit price: 4 - Quantity: 97").ordered
    expect(@io).to receive(:puts).with("#2 - Class Popcorn - Unit price: 2 - Quantity: 68").ordered

    Application.new('shop_manager_test', @io, ItemRepository.new, OrderRepository.new).run
  end

  it 'creates a new item' do
    expect(@io).to receive(:gets).and_return("2").ordered
    expect(@io).to receive(:puts).with("Please enter the item name").ordered
    expect(@io).to receive(:gets).and_return("added item").ordered
    expect(@io).to receive(:puts).with("Please enter the item unit price").ordered
    expect(@io).to receive(:gets).and_return("100").ordered
    expect(@io).to receive(:puts).with("Please enter the item quantity").ordered
    expect(@io).to receive(:gets).and_return("50").ordered
    expect(@io).to receive(:puts).with("Item added: #3 - added item - Unit price: 100 - Quantity: 50").ordered

    Application.new('shop_manager_test', @io, ItemRepository.new, OrderRepository.new).run
  end

  it 'prints all orders' do
    expect(@io).to receive(:gets).and_return("3").ordered
    expect(@io).to receive(:puts).with("here is the list of all orders:").ordered
    expect(@io).to receive(:puts).with("#1 - David - Order date: 2022-08-10 - Item ID: 1").ordered
    expect(@io).to receive(:puts).with("#2 - Anna - Order date: 2022-09-12 - Item ID: 2").ordered

    Application.new('shop_manager_test', @io, ItemRepository.new, OrderRepository.new).run
  end

  it 'creates a new order' do
    expect(@io).to receive(:gets).and_return("4").ordered
    expect(@io).to receive(:puts).with("Please enter the customer name").ordered
    expect(@io).to receive(:gets).and_return("Hans").ordered
    expect(@io).to receive(:puts).with("Please enter the order date").ordered
    expect(@io).to receive(:gets).and_return('2022-02-02').ordered
    expect(@io).to receive(:puts).with("Please enter the item ID").ordered
    expect(@io).to receive(:gets).and_return(1).ordered
    expect(@io).to receive(:puts).with("Order added: #3 - Hans - Unit price: 2022-02-02 - Quantity: 1").ordered

    Application.new('shop_manager_test', @io, ItemRepository.new, OrderRepository.new).run
  end
end
