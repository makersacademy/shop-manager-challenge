class ItemRepository
  # def initialize(database_connection:)
  #   @database_connection = database_connection
  # end
  def create(item)
    sql = 'INSERT INTO items (name, price, stock) VALUES ($1, $2, $3);'
    params = [item.name, item.price, item.stock]
    DatabaseConnection.exec_params(sql, params)
  end
  
  def all
    sql = 'SELECT * FROM items;'
    result = DatabaseConnection.exec_params(sql, [])
    result.map do |record|
      item = Item.new(
        name: record['name'],
        price: record['price'],
        stock: record['stock']
      )
      item.id = record['id']
      item
    end
  end
end
