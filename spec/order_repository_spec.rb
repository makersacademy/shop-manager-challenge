require 'order_repository'
require 'order'
require 'item'

def reset_orders_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'items_orders_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  it "returns all orders with details and the items that were ordered" do
    repo = OrderRepository.new
    orders = repo.all
    expect(orders.length).to eq  3

    expect(orders[0].id).to eq '1'
    expect(orders[0].customer_name).to eq 'John Treat'
    expect(orders[0].date_placed).to eq '2022-08-12'
    expect(orders[0].items[0].name).to eq 'Oak Bookshelf'
    expect(orders[0].items[1].name).to eq 'Oriental Rug'
    expect(orders[0].items[2].name).to eq 'Leather Sofa'

    expect(orders[1].id).to eq '2'
    expect(orders[1].customer_name).to eq 'Amelia Macfarlane'
    expect(orders[1].date_placed).to eq '2022-08-14'
    expect(orders[1].items[0].name).to eq 'White Desk Lamp'

    expect(orders[2].id).to eq '3'
    expect(orders[2].customer_name).to eq 'Eleanor Borgate'
    expect(orders[2].date_placed).to eq '2022-09-02'
    expect(orders[2].items[0].name).to eq 'Aloe Vera Houseplant'
    expect(orders[2].items[1].name).to eq 'White Desk Lamp'
    expect(orders[2].items[2].name).to eq 'Oak Bookshelf'
  end

  it "adds a new order to the database and returns it when asked to" do
    repo = OrderRepository.new

    item1 = Item.new
    item1.name = 'Leather Sofa'
    item2 = Item.new
    item2.name = 'Oriental Rug'

    order = Order.new
    order.customer_name = 'Bella Cruxiante'
    order.date_placed = '2022-09-09'
    order.items << item1
    order.items << item2

    repo.create(order)

    created_order = repo.all.last
    expect(created_order.customer_name).to eq 'Bella Cruxiante'
    expect(created_order.date_placed).to eq '2022-09-09'
    expect(created_order.items[0].name).to eq 'Leather Sofa'
    expect(created_order.items[1].name).to eq 'Oriental Rug'
  end
end