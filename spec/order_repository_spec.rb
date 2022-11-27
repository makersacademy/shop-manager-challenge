require 'order_repository'
require 'order'
require 'spec_helper'

describe OrderRepository do

  def reset_orders_table
    seed_sql = File.read('spec/seeds_stock.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_orders_table
  end

  it "puts a list of all orders" do

    io = double :io

    expect(io).to receive(:puts).with("1 - Lucas Smith - 2022-10-28 - 1")
    expect(io).to receive(:puts).with("2 - Abigail Brown - 2022-11-28 - 3")
    expect(io).to receive(:puts).with("3 - Sally Bright - 2022-11-16 - 1")

    repo = OrderRepository.new(io)
    repo.all

  end


  it "Adds an order to the database when the create method is used" do

    io = double :io

    expect(io).to receive(:puts).with("1 - Lucas Smith - 2022-10-28 - 1")
    expect(io).to receive(:puts).with("2 - Abigail Brown - 2022-11-28 - 3")
    expect(io).to receive(:puts).with("3 - Sally Bright - 2022-11-16 - 1")
    expect(io).to receive(:puts).with("4 - Jenny Boyle - 2022-11-05 - 2")

    repo = OrderRepository.new(io)
    order = Order.new

    order.id = 4
    order.customer_name = 'Jenny Boyle'
    order.date = '2022-11-05'
    order.item_id = 2

    repo.create(order)
    repo.all

  end

end
