require 'pg'

class DatabaseConnection
  def self.connect(db_name)
    @connection = PG.connect({host: localhost, dbname: db_name})
  end

  def self.exec_params(query, params)
    raise 'Database connection not established' if @connection.nil?
    @connection.exec(query, params)
  end
end