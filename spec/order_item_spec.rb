require 'order_item_repository'


RSpec.describe OrderItemRepository do
  let(:repository) { OrderItemRepository.new }

  def reset_shop_manager_table
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end


  before(:each) do 
    reset_shop_manager_table
  end

  it 'returns a list of order items with associated orders and items' do
    repository = OrderItemRepository.new

    order_items = repository.all

    expect(order_items.length).to eq(3)

    # First order item
    expect(order_items[0].order.id).to eq(1)
    expect(order_items[0].order.customer_name).to eq('Joe Hannis')
    expect(order_items[0].order.order_date).to eq('2023-05-25')      
    expect(order_items[0].item.id).to eq(1)
    expect(order_items[0].item.name).to eq('CPU')
    expect(order_items[0].item.unit_price).to eq(199.99)
    expect(order_items[0].item.quantity).to eq(10)

    # Second order item
    expect(order_items[1].order.id).to eq(1)
    expect(order_items[1].order.customer_name).to eq('Joe Hannis')
    expect(order_items[1].order.order_date).to eq('2023-05-25')
    expect(order_items[1].item.id).to eq(2)
    expect(order_items[1].item.name).to eq('GPU')
    expect(order_items[1].item.unit_price).to eq(499.99)
    expect(order_items[1].item.quantity).to eq(5)

    # Third order item
    expect(order_items[2].order.id).to eq(2)
    expect(order_items[2].order.customer_name).to eq('Sean Peters')
    expect(order_items[2].order.order_date).to eq('2023-05-26')
    expect(order_items[2].item.id).to eq(1)
    expect(order_items[2].item.name).to eq('CPU')
    expect(order_items[2].item.unit_price).to eq(199.99)
    expect(order_items[2].item.quantity).to eq(10)
  end
end