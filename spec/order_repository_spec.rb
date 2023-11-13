require_relative '../lib/order_repository'
require_relative "../lib/database_connection"


RSpec.describe OrderRepository do
  def reset_items_and_orders_tables
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  describe OrderRepository do
    before(:each) do 
      reset_items_and_orders_tables
    end

    it "returns a list of all the orders" do
      repo = OrderRepository.new

      orders = repo.all
      
      expect(orders.length).to eq 3
      expect(orders[0].id).to eq '1'
      expect(orders[0].customer_name).to eq 'Andrea'
      expect(orders[0].date).to eq '2023-01-18'
      expect(orders[0].item_id).to eq '1'

      expect(orders[1].id).to eq '2'
      expect(orders[1].customer_name).to eq 'Céline'
      expect(orders[1].date).to eq '2023-03-14'
      expect(orders[1].item_id).to eq '2'
    end

    it "creates a new order" do
     
      repo = OrderRepository.new
      repo.create('Ilaria', '2023-04-29', '1')
      orders = repo.all
      expect(orders.length).to eq 4
    end
  end
end