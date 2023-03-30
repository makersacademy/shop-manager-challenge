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
    # ### This section checks methods which format object into strings ###  
    # it 'returns the list of all customers and their names in a formatted string array' do
    #   customers = repo.customer_list
    #   expect(customers.length).to eq 5
    #   expect(customers[0]).to eq "Customer ID: 1, Name: Customer_1"
    #   expect(customers[-1]).to eq "Customer ID: 5, Name: Customer_5"
    # end   

    # it 'returns the list of all orders alongside their time, content and customer info in a formatted string array' do
    #   ## Returns the array sorted by descending date order
    #   orders = repo.order_list
    #   expect(orders.length).to eq 18
    #   expect(orders[0]).to eq "Date: 2023-03-01, Order Item: Peanut Butter, Customer Name: Customer_4"
    #   expect(orders[-1]).to eq "Date: 2023-01-08, Order Item: Soap, Customer Name: Customer_3"
    # end

    # it 'returns a string list of all items ordered by a specific customer in a descending order based on order time' do
    #   orders = repo.list_of_items_ordered_by_customer("Customer_3")
    #   expect(orders.length).to eq 7
    #   expect(orders[0]).to eq "On 2023-02-18, ordered Coal"
    #   expect(orders[-2]).to eq "On 2023-01-08, ordered Chocolate"
    # end
  end
end