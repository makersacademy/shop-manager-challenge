require 'order_repository'

RSpec.describe OrderRepository do
  def reset_orders_table
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
    end

  before(:each) do 
    reset_orders_table
  end
 
  it 'returns a list of ALL' do
    repo = ItemRepository.new
    
    items = repo.all
    expect(items.length).to eq(3)
    expect(items.first.name).to eq('Henry Vacuum Hoover')
    expect(items.first.unit_price).to eq(50)
    expect(items.first.quantity).to eq(20)
  end

  it 'creates a new order' do
    repo = OrderRepository.new

    new_order = Order.new
    new_order.customer_name = 'Betty'
    new_order.date = '2022-12-23'
    new_order.item_id = 1

    repo.create(new_order)

    all_orders = repo.all
    expect(all_orders).to include(
      have_attributes(
        customer_name: new_order.customer_name, 
        date: '2022-12-23', 
        item_id: 1
        )
    )
  end
end