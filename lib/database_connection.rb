# file: lib/database_connection.rb

def self.connect
  # If the environment variable (set by Render)
  # is present, use this to open the connection.
  if ENV['DATABASE_URL'] != nil
    @connection = PG.connect(ENV['DATABASE_URL'])
    return
  end

  if ENV['ENV'] == 'test'
    database_name = 'music_library_test'
  else
    database_name = 'music_library'
  end
  @connection = PG.connect({ host: '127.0.0.1', dbname: database_name })
end