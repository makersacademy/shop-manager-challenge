require 'order_repository'

RSpec.describe OrderRepository do

  def reset_orders_table
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  describe OrderRepository do
    before(:each) do 
      reset_orders_table
    end

    it 'returns all orders' do

    repo = OrderRepository.new
    orders = repo.all

    expect(orders.length).to eq(2)

    expect(orders[0].id).to eq('1')
    expect(orders[0].customer).to eq('Dai Jones')
    expect(orders[0].date).to eq('2023-01-30')
    expect(orders[0].item_id).to eq('1')

    expect(orders[1].id).to eq('2')
    expect(orders[1].customer).to eq('Bobby Price')
    expect(orders[1].date).to eq('2023-02-03')
    expect(orders[1].item_id).to eq('2')
    end

    it 'creates a new order' do
      
      repo = OrderRepository.new

      order = Order.new
      order.customer = 'Annalise Keating'
      order.date = '02/05/2023'
      order.item_id = '1'

      repo.create(order)

      order = repo.all
      last_order = order.last
      expect(last_order.customer).to eq('Annalise Keating')
      expect(last_order.date).to eq('2023-02-05')
      expect(last_order.item_id).to eq('1')
    end
  end
end  