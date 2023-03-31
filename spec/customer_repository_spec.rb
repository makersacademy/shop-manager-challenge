require 'customer_repository'

def reset_all_tables
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  seed_sql = File.read('spec/seeds_all.sql')
  connection.exec(seed_sql)
end

describe CustomerRepository do
  before(:each) do 
    reset_all_tables
  end
  let(:repo) { CustomerRepository.new }

  context 'when checking db methods' do
    ### This section checks methods which communicate with the database ###
    it 'returns id number of customer if they already exist in database' do
      expect(repo.retrieve_customer_by_name("Customer_5")).to eq 5
    end

    it 'returns false if customer does not exist in database' do
      expect(repo.retrieve_customer_by_name("Customer_10")).to eq false
    end

    it 'adds a new customer to database' do
      repo.add_customer("Customer_6")
      expect(repo.retrieve_customer_by_name("Customer_6")).to eq 6
    end
  end

  context 'when reformatted' do
    ### This section checks methods which format object into strings ###  
    it 'returns a string list of all items ordered by a specific customer in a descending order based on order time' do
      orders = repo.list_of_items_ordered_by_customer("Customer_3")
      expect(orders.length).to eq 7
      expect(orders[0]).to eq "On 2023-02-18, ordered Coal"
      expect(orders[-2]).to eq "On 2023-01-08, ordered Chocolate"
    end
  end
end