$LOAD_PATH << File.join(File.dirname(__FILE__), '/lib')
require 'database_connection'
require 'application'
require 'item_repository'
require 'order_repository'
require 'item'
require 'order'

#connection passed into app as mock in tests and real in app.rb
#put host & db_name as ENV variables
database_connection = DatabaseConnection.connect({host: 'ENV VAR', dbname: 'ENV VAR'})

app = Application.new(
  item_repository: OrderRepository.new(database_connection: database_connection),
  order_repository: ItemRepository.new(database_connection: database_connection),
  io: Kernel
)


