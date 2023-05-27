require 'order_repository'
require 'order'

def reset_database
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_database
  end
  
  describe "#all" do
    it "returns all orders" do
      repo = OrderRepository.new
      orders = repo.all
      expect(orders.length).to eq 2
      expect(orders.first.customer_name).to eq 'Rodney Howell'
    end
  end
end
