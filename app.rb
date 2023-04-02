require_relative 'lib/shop_repository'
require_relative 'lib/database_connection'

class Application
  def initialize(database_name, shop_repository, io = Kernel)
    DatabaseConnection.connect(database_name)
    @io = io
    @shop_repository = shop_repository
  end

  def run
    puts "Everything is Awesome!"
  end
end

if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    ShopRepository.new,
    io = Kernel
  )
  app.run
end
