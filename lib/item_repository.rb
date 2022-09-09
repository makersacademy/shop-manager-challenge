class ItemRepository
  def initialize(database_connection:)
    @database_connection = database_connection
  end

  def create(item)
    sql = ''
    params = []
    @database_connection.exec_params(sql, params)
  end
  
  def all
    #returns an array of Items
  end
end