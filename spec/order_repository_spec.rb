require 'item_repository'
require 'order_repository'
require 'item'
require 'order'

RSpec.describe 'OrderRepository' do
  let(:repo) { OrderRepository.new }
  def reset_tables
    sql = File.read('./spec/seeds_test.sql')
    connection = PG.connect({ host: ENV['DATABASE_HOST'], dbname: ENV['DATABASE_NAME'] })
    connection.exec(sql) 
  end

  before(:each) do
    reset_tables
  end

  describe '#all_with_item' do
    it 'returns all orders with items' do
      orders = repo.all_with_item
      expect(orders.length).to eq 3
      expect(orders[0].customer).to eq 'Thundercat'
      expect(orders[1].date).to eq '15/06/2022'
      expect(orders[2].item.name).to eq 'Sun Lamp'
      expect(orders[1].item.price).to eq '89'
      expect(orders[0].item.stock).to eq '25'
      expect(orders[2].item.id).to eq '1'
    end
  end

  describe '#create' do
    it 'creates a new order' do
      order = Order.new(
        customer: 'Bugs Bunny',
        date: '20/08/2022'
      )
      order.item_id = '2'
      repo.create(order)
      orders = repo.all_with_item
      expect(orders.length).to eq 4
      expect(orders.last.customer).to eq 'Bugs Bunny'
      expect(orders.last.date).to eq '20/08/2022'
      expect(orders.last.item_id).to eq '2'
    end
  end
end
