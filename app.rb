require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    show 'Welcome to the shop management program!'
    show 'What do you want to do?'
    show '1 - List all items'
    show '2 - Create a new item'
    show '3 - List all orders'
    show '4 - Create a new order'
    show 'Enter your choice:'
  end

  private

  def show(message)
    @io.puts(message)
  end

  def prompt(message)
    @io.puts(message)
    @io.gets.chomp
  end

  def prompt_for_input
    input = prompt 'Enter your choice:'
    case input
    when '1'
      show 'Here is the list of albums:'
      @item_repository.all.each do |album|
        show "* #{album.id} - #{album.title} (#{album.release_year})"
      end
    else
      show 'Here is the list of artists:'
      @order_repository.all.each do |artist|
        show "* #{artist.id} - #{artist.name} (#{artist.genre})"
      end
    end
  end
end

if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end
