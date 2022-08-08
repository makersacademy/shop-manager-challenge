
def reset_albums_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_database_test' })
  connection.exec(seed_sql)
end

before(:each) do 
  reset_albums_table
end
