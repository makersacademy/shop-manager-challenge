$LOAD_PATH << File.join(File.dirname(__FILE__), '/lib')
require 'database_connection'
require 'application'
require 'item_repository'
require 'order_repository'
require 'item'
require 'order'
require 'dotenv/load'

DatabaseConnection.connect

app = Application.new(
  item_repository: ItemRepository.new,
  order_repository: OrderRepository.new,
  io: Kernel
)

app.run
