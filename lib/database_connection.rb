require 'pg'

class DatabaseConnection

  def self.connect(dbname)
    @@connection = PG.connect({host: '127.0.0.1', dbname: dbname})

  end 

  def self.exec_params(query, params)
    @@connection.exec_params(query, params)
  end 

  def self.exec(query)
    @@connection.exec(query)
  end 

end 