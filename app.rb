# app

# init

require_relative './lib/database_connection'
DatabaseConnection.connect('shop')

require_relative './lib/item_repository'
require_relative './lib/order_repository'
require_relative './lib/user_interface'

# interface

class TerminalIO
  def gets
    return Kernel.gets
  end
  def puts(message)
    Kernel.puts(message)
  end
end

io = TerminalIO.new
user_interface = UserInterface.new(io)
user_interface.run