require 'pg'

class DatabaseConnection
  def self.connect
    @connection = PG.connect({ host: ENV['DATABASE_HOST'], dbname: ENV['DATABASE_NAME'] })
  end

  def self.exec_params(query, params)
    raise 'Database connection not established.' if @connection.nil?
    @connection.exec(query, params)
  end
end
