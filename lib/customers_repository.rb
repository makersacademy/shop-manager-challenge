require 'database_connection'
require 'customer_model'

class CustomersRepository
  def all
    sql = 'SELECT id, customer_name FROM customers;'
    result = DatabaseConnection.exec_params(sql, [])
    customer_list = []
    result.each do |record|
      customer = Customer.new
      customer.id = record['id'].to_i
      customer.customer_name = record['customer_name']
      customer_list << customer
    end
    return customer_list
  end
  
  def find(id)
    sql = 'SELECT id, customer_name FROM customers WHERE id = $1;'
    result = DatabaseConnection.exec_params(sql, [id])
    record = result[0]
    customer = Customer.new
    customer.id = record['id'].to_i
    customer.customer_name = record['customer_name']
    return customer
  end
  
  def create(customer)
    sql = 'INSERT INTO customers (customer_name) VALUES ($1);'
    params = [customer.customer_name]
    result = DatabaseConnection.exec_params(sql, params)
    return nil
  end
  
  def update(customer)
    sql = 'UPDATE customers SET customer_name = $1;'
    params = [customer.customer_name]
    result = DatabaseConnection.exec_params(sql, params)
    return nil
  end
  
  def delete(id)
    sql = 'DELETE FROM customers WHERE id = $1;'
    result = DatabaseConnection.exec_params(sql, [id])
    return nil
  end
end
