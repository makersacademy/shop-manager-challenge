require "stocks"

class StocksRepository
  def all
    stocks = []
          
    sql = 'SELECT id, name, price, quantity FROM stocks;'
    result_set = DatabaseConnection.exec_params(sql, [])
  
    result_set.each do |record|
      stock = Stocks.new
  
      stock.id = record['id']
      stock.name = record['name']
      stock.price = record['price']
      stock.quantity = record['quantity']
  
      stocks << stock
  end
  
    return stocks
  end
    
  def create(stock)

    sql = 'INSERT INTO stocks (name, price, quantity) VALUES($1, $2, $3)'
    sql_params = [stock.name, stock.price, stock.quantity]
  
    DatabaseConnection.exec_params(sql, sql_params)
  
    return nil 
  end 
end