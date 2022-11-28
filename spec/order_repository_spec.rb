require 'order_repository'

describe OrderRepository do 

def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_database' })
  connection.exec(seed_sql)
end

  describe OrderRepository do
    before(:each) do 
      reset_orders_table
    end
  end 

  context '#all' do 
    it 'returns a list of all orders' do 
      repo = OrderRepository.new

      orders = repo.all

      expect(orders.length).to eq 3

      expect(orders[0].id).to eq '1'
      expect(orders[0].customer_name).to eq 'Monika Geller'
      expect(orders[0].date).to eq '1995-01-02'
      expect(orders[0].item_id).to eq '2'

      expect(orders[2].id).to eq '3'
      expect(orders[2].customer_name).to eq 'Pheobe Buffay'
      expect(orders[2].date).to eq '1997-04-12'
      expect(orders[2].item_id).to eq '3'
    end 
  end 

  

end 
