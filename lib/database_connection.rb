require 'pg'
require 'dotenv/load'

class DatabaseConnection
  def self.connect(database_name)
    @connection = PG.connect({ host: ENV['HOST'], dbname: database_name, user: 'postgres', password: ENV['PASSWORD'] })
  end

  def self.exec_params(query, params)
    if @connection.nil?
      raise 'DatabaseConnection.exec_params: Cannot run a SQL query as the connection to'\
      'the database was never opened. Did you make sure to call first the method '\
      '`DatabaseConnection.connect` in your app.rb file (or in your tests spec_helper.rb)?'
    end
    @connection.exec_params(query, params)
  end
end