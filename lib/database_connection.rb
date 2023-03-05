require 'pg'

class DatabaseConnection
  def self.connect(shop_manager_challenge)
     @connection = PG.connect({ host: '127.0.0.1', dbname: shop_manager_challenge })
  end

  def self.exec_params(query, params)
    @connection.exec_params(query, params)
  end
end