# This file has been copy/pasted with the idea that it is used as a library
# it has a very specific content which I fail to memorise and can always use
# from reference. Taken from project setup guide.

require 'pg'

class DatabaseConnection
  def self.connect(database_name)
    @connection = PG.connect({ host: '127.0.0.1', dbname: database_name })
  end

  def self.exec_params(query, params)
    if @connection.nil?
      raise 'DatabaseConnection.exec_params: Cannot run a SQL query as the' \
      'connection to the database was never opened. Did you make sure to call' \
      'first the method `DatabaseConnection.connect` in your app.rb file (or' \
      ' in your tests spec_helper.rb)?'
    end
    @connection.exec_params(query, params)
  end
end
