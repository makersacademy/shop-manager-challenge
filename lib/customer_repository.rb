require_relative 'customer'

class CustomerRepository

  def all
    sql_statement = "SELECT * FROM customers"
    output = []
    results = DatabaseConnection.exec_params(sql_statement, [])
    results.each { |raw_data|
      customer = Customer.new
      customer.id = raw_data['id']
      customer.name = raw_data['name']
      output << customer
    }
  return output
  end

  
end