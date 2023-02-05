
class StockRepository
# Selecting all records
  # No arguments
  def all
      sql = 'SELECT id, item, price, quantity FROM stocks;'
      result_set = DatabaseConnection.exec_params(sql, [])

      stocks = []

      result_set.each do |record|
      stock = Stock.new

      stock.id = record['id']
      stock.item = record['item']
      stock.price = record['price']
      stock.quantity = record['quantity']

      stocks << stock
    end
    return stocks
  end

    # Executes the SQL query:
   # SELECT * FROM stocks;

    # Returns an array of Stock objects.


  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, item, price, quantity FROM students WHERE id = $1;

    # Returns a single Stock object.
  end