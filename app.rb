require_relative 'lib/database_connection'


class Application 

  def initialize(io)
    @io = io
  end

  def run
    @io.puts "What do you want to do?"
    @io.puts "1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order"
  end
end
