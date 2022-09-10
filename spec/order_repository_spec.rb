require 'order'
require 'order_repository'

RSpec.describe OrderRepository do
  def reset_tables
    seed_sql = File.read('spec/seeds_tests.sql')
    user = ENV['PGUSER1'].to_s
    password = ENV['PGPASSWORD'].to_s
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager', user: user, password: password })

    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_tables
  end

  describe "#all_orders" do
    it "returns array of all orders including customer name" do
      repo = OrderRepository.new
      result = repo.all_orders

      expect(result[0].id).to eq "1"
      expect(result[0].customer).to eq "Wendy"
      expect(result[0].item).to eq "Item 1"
      expect(result[0].date).to eq "2022-01-13"
      expect(result[1].id).to eq "2"
      expect(result[1].customer).to eq "Jovi"
      expect(result[1].item).to eq "Item 2"
      expect(result[1].date).to eq "2022-02-13"
    end
  end

  describe "#create_order" do
    it "returns array of all orders" do
      order = Order.new
      order.customer = "Chandler"
      order.item = "Item 1"
      order.date = "2022-05-13"

      repo = OrderRepository.new
      repo.create_order(order)
      result = repo.all_orders.last

      expect(result.id).to eq "5"
      expect(result.customer).to eq "Chandler"
      expect(result.item).to eq "Item 1"
      expect(result.date).to eq "2022-05-13"
    end
  end
end