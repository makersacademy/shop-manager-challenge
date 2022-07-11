require 'stock'

class StockRepository

    def all 
        stocks = []
        sql = 'SELECT * FROM stocks;'
        result = DatabaseConnection.exec_params(sql, [])
        result.each do |item|
            stock = Stock.new 
            stock.id = item['id']
            stock.name = item['name']
            stock.price = item['price']
            stock.quantity = item['quantity']
            stocks << stock
        end 
        return stocks
    end 

    def find(id)
        sql = 'SELECT * FROM stocks WHERE id = $1;'
        params = [id]
        result = DatabaseConnection.exec_params(sql, params)
        record = result[0]

        stock = Stock.new
        stock.id = record['id']
        stock.name = record['name']
        stock.price = record['price']
        stock.quantity = record['quantity']

        return stock

    end 

    def create(stock) 
        sql = 'INSERT INTO stocks (id, name, price, quantity) VALUES ($1, $2, $3, $4);'
        params = [stock.id, stock.name, stock.price, stock.quantity]

        DatabaseConnection.exec_params(sql, params)

        return nil
    end

    def delete(id)
        sql = 'DELETE FROM stocks WHERE id = $1;'
        DatabaseConnection.exec_params(sql, [id])

        return nil
    end

    def update(id, col, val) 
        
        if col == 'name'
            sql = 'UPDATE stocks SET name = $2 WHERE id = $1;'
        elsif col == 'price'
            sql = 'UPDATE stocks SET price = $2 WHERE id = $1;'
        elsif col == 'quantity'
            sql = 'UPDATE stocks SET quantity = $2 WHERE id = $1;'
        end 
        params = [id, val]
        DatabaseConnection.exec_params(sql, params)

        return nil
    end 
end 