# require 'customer_repository'

# def reset_customers_table
#   seed_sql = File.read('spec/seeds_customers.sql')
#   connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
#   connection.exec(seed_sql)
# end

# describe CustomerRepository do
#   before(:each) do 
#     reset_customers_table
#   end
#   let(:repo) { CustomerRepository.new }

#   it 'returns the list of all customers in an array' do
#     customers = repo.all
#     expect(customers.length).to eq 5
#     expect(customers[0].name).to eq "Customer_1"
#     expect(customers[-1].name).to eq "Customer_5"
#   end

# it ''

# end