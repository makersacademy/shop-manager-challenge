class OrderRepository
  def initialize(database_connection:)
    @database_connection = database_connection
  end
  
  def create(order)
    sql = ''
    params = []
    @database_connection.exec_params(sql, params)
  end

  def all_with_item
    #returns array of Order objects with @item = Item object
  end
end