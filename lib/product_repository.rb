require_relative "product"

class ProductRepository 


  def all 

    sql = 'SELECT products.id, products.name, products.unit_price, products.quantity FROM products;'
    sql_params = []

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    products = []

    result_set.each do |record|

     product = Product.new 
     product.id = record["id"]
     product.name = record["name"]
     product.unit_price = record["unit_price"]
     product.quantity = record["quantity"]

     products << product

    end 

    return products
    

  end 


  
  def create(new_item)

    sql = 'INSERT INTO products (name, unit_price, quantity) VALUES ($1, $2, $3);'
    sql_params = [new_item.name, new_item.unit_price, new_item.quantity]

    DatabaseConnection.exec_params(sql, sql_params)

    return "#{new_item.name} has been added to the inventory database."

  end




end