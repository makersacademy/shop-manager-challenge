require_relative './lib/io_manager'
require_relative './lib/database_connection'

io_manager = IOManager.new(Kernel)
DatabaseConnection.connect('shop_manager')

while true
  io_manager.run 
end
