require_relative './product'

class ProductRepository

    def all 
       sql = 'SELECT * FROM products;'
       result = DatabaseConnection.exec_params(sql, [])

       products = []

       result.each do |record|
        product = Product.new
        product.id = record['id']
        product.name = record['name']
        product.unit_price = record['unit_price']
        product.quantity = record['quantity']

        products << product
       end

       return products

    end

    def find(id)

        sql = 'SELECT * FROM products WHERE id = $1;'

        params = [id]
        
        result = DatabaseConnection.exec_params(sql, params)

        product = Product.new
        product.id = result[0]['id']
        product.name = result[0]['name']
        product.unit_price = result[0]['unit_price']
        product.quantity = result[0]['quantity']

        return product
    end

    def create(product)
        sql = 'INSERT INTO products
        (name, unit_price, quantity)
        VALUES ($1, $2, $3)'

        params = [product.name, product.unit_price, product.quantity]
        result = DatabaseConnection.exec_params(sql, params)    
        return nil

    end

    def delete(id)
        sql = 'DELETE FROM products WHERE id = $1'
        params = [id]
        result = DatabaseConnection.exec_params(sql, params)    
        return nil
    end
end