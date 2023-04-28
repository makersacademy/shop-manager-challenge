def reset_stock_table
  seed_sql = File.read('spec/stock_control.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'stock_control_test' })
  connection.exec(seed_sql)
end