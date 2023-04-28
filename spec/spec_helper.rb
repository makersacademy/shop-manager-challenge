require 'simplecov'
require 'simplecov-console'
require 'database_connection'

DatabaseConnection.connect('stock_control_test')

def reset_stock_table
  seed_sql = File.read('spec/stock_control.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'stock_control_test' })
  connection.exec(seed_sql)
end

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  # Want a nice code coverage website? Uncomment this next line!
  # SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start

RSpec.configure do |config|
  config.after(:suite) do
    puts
    puts "\e[33mHave you considered running rubocop? It will help you improve your code!\e[0m"
    puts "\e[33mTry it now! Just run: rubocop\e[0m"
  end
end
