require 'customers_repository'

RSpec.describe CustomersRepository do
  def reset_customers_table
    seed_sql = File.read('spec/seeds_shop_manager_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_customers_table
  end

  it 'Gets all customers.' do
    repo = CustomersRepository.new
    customers = repo.all
    expect(customers.length).to eq 3
    expect(customers[0].customer_name).to eq 'Customer1'
    expect(customers[1].customer_name).to eq 'Customer2'
  end

  it 'Gets a single customer.' do
    repo = CustomersRepository.new
    customer = repo.find(2)
    expect(customer.id).to eq 2
    expect(customer.customer_name).to eq 'Customer2'
  end

  it 'Creates a customer.' do
    repo = CustomersRepository.new
    customer = Customer.new
    customer.customer_name = 'Customer4'
    repo.create(customer)
    customers = repo.all
    newest_customer = customers.last
    expect(newest_customer.id).to eq 4
  end

  it 'Updates a customer.' do
    repo = CustomersRepository.new
    customer = repo.find(2)
    customer.customer_name = 'Customer 2'
    repo.update(customer)
    expect(repo.find(2).customer_name).to eq ('Customer 2')
  end

  it 'Deletes a customer.' do
    repo = CustomersRepository.new

    customer1 = Customer.new
    customer1.customer_name = 'Customer4'
    repo.create(customer1)

    customer2 = Customer.new
    customer2.customer_name = 'Customer5'
    repo.create(customer2)
    customers = repo.all
    repo.delete(4)
    customers = repo.all
    search = repo.find(5)
    expect(search.customer_name).to eq 'Customer5'
    expect(customers.length).to eq 4
  end
end
