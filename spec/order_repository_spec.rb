require 'order_repository'

def reset_all_tables
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  seed_sql = File.read('spec/seeds_all.sql')
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_all_tables
  end
  let(:repo) { OrderRepository.new }

  context 'when checking database methods' do
    ### This section checks methods which communicate with the database ###
    it 'adds an order to orders table' do
      fake_date = Time.new(1999, 03, 21, 9, 30, 00).strftime("%Y-%m-%d")
      input_parameters = {item_id: 7, customer_id: 4}
      repo.add_order(input_parameters, date=fake_date)
      last_order = repo.last_order
      expect(last_order.item_id).to eq 7
      expect(last_order.customer_id).to eq 4
      expect(last_order.order_time).to eq "1999-03-21"
    end

    it 'checks the last order that was made' do
      last_order = repo.last_order
      expect(last_order.item_id).to eq 1
      expect(last_order.customer_id).to eq 5
      expect(last_order.order_time).to eq "2023-02-22"
    end

    it 'retrieves all orders made in database' do
      all_orders = repo.all_orders
      expect(all_orders.length).to eq 18
      expect(all_orders[0].id).to eq 17
      expect(all_orders[0].customer_name).to eq "Customer_4"
      expect(all_orders[0].item_name).to eq "Peanut Butter"
    end
  end 

  context 'when reformatted' do
    it 'returns the list of all orders alongside their time, content and customer info in a string array' do
      ## Returns the array sorted by descending date order
      orders = repo.order_list
      expect(orders.length).to eq 18
      expect(orders[0]).to eq "Date: 2023-03-01, Order ID: 17, Order Item: Peanut Butter, Customer Name: Customer_4"
      expect(orders[-1]).to eq "Date: 2023-01-08, Order ID: 1, Order Item: Soap, Customer Name: Customer_3"
    end
  end
end


