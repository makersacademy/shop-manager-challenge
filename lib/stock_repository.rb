require_relative './stock'

class StockRepository

  def all
    sql = 'SELECT id, item, unit_price, quantity FROM stocks;'
    result = DatabaseConnection.exec_params(sql, [])
    return populate_stock(result)
  end

  def find(id)
    sql = 'SELECT id, item, unit_price, quantity FROM stocks WHERE id = $1;'
    sql_params = [id]
    result = DatabaseConnection.exec_params(sql, sql_params)

    stock = Stock.new

    stock.id = result[0]['id']
    stock.item = result[0]['item']
    stock.unit_price = result[0]['unit_price']
    stock.quantity = result[0]['quantity']

    return stock
  end

  def create(stock)
    sql = 'INSERT INTO stocks (item, unit_price, quantity)
    VALUES ($1, $2, $3);'
    sql_params = [stock.item, stock.unit_price, stock.quantity]
    result = DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def delete(id)
    sql = 'DELETE FROM stocks WHERE id = $1;'
    sql_params = [id]
    result = DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def update(id)
    sql = 'UPDATE stocks SET item = $1, unit_price = $2, quantity = $3 WHERE id = $4;'
    sql_params = ['new_item2', '2.00', '2', id]
    result = DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  private

  def populate_stock(result)
    stocks = []
    result.each do |inventory|
      stock = Stock.new
      stock.id = inventory['id']
      stock.item = inventory['item']
      stock.unit_price = inventory['unit_price']
      stock.quantity = inventory['quantity']
      stocks << stock
    end
    return stocks
  end
end
