require_relative './stock'
class StockRepo
  def all 
    stocks = []
    sql = 'SELECT id, item_name, price, quantity FROM stocks;'
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each do |record| 
      stock = Stock.new 
      stock.id = record['id']
      stock.item_name = record['item_name']
      stock.price = record['price']
      stocks << stock
    end 
    return stocks
end
  def find(id)
    sql = 'SELECT item_name, price, quantity FROM stocks WHERE id = $1;'
    sql_params = [id]
    
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]
 
    stock = Stock.new 
    stock.item_name = record['item_name']
    stock.price = record['price']
    stock.quantity = record['quantity']

    return stock
  end 
  def create(stock)
    sql = 'INSERT INTO stocks (id, item_name, price, quantity) VALUES($1, $2, $3, $4);'
    sql_params = [stock.id, stock.item_name, stock.price, stock.quantity]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end 
  def delete(id)
    sql = 'DELETE FROM stocks WHERE id = $1'
    sql_params = [id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
end  
end 