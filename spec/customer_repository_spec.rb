require 'customer_repository'

def reset_customers_table
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  seed_sql = File.read('spec/seeds_customers.sql')
  connection.exec(seed_sql)
  seed_sql = File.read('spec/seeds_orders.sql')
  connection.exec(seed_sql)
end

describe CustomerRepository do
  before(:each) do 
    reset_customers_table
  end
  let(:repo) { CustomerRepository.new }

  context 'when checking db methods' do
    ### This section checks methods which communicate with the database ###
    it 'returns the list of all customers in an array' do
      customers = repo.all
      expect(customers.length).to eq 5
      expect(customers[0].name).to eq "Customer_1"
      expect(customers[-1].name).to eq "Customer_5"
    end
  end

  context 'when reformatted' do
    ### This section checks methods which format object into strings ###  
    it 'returns the list of all customers and their names in a formatted string array' do
      customers = repo.customer_list
      expect(customers.length).to eq 5
      expect(customers[0]).to eq "Customer ID: 1, Name: Customer_1"
      expect(customers[-1]).to eq "Customer ID: 5, Name: Customer_5"
    end   

    it 'returns the list of all orders alongside their time and customer info in a formatted string array' do
      orders = repo.order_list
      expect(orders.length).to eq 18
      expect(orders[0]).to eq "Order ID: 17, Date: 2023-03-01, Customer Name: Customer_4"
    end
  end
end