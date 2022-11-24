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
    print_intro
    case menu_choice
    when '1' then print_albums
    when '2' then print_artists
    when '9' then exit
    end
  end

  def print_intro
    @io.puts "Welcome to the shop management program!\n"
    @io.puts 'What would you like to do?'
    @io.puts ' 1 - List all shop items'
    @io.puts ' 2 - Create a new item'
    @io.puts ' 1 - List all orders'
    @io.puts ' 2 - Create a new order'
  end

  # def menu_choice
  #   @io.puts 'Enter your choice: '
  #   choice = @io.gets.chomp
  #   until %w[1 2 9].include?(choice)
  #     @io.puts 'Enter your choice: '
  #     choice = @io.gets.chomp
  #   end
  #   choice
  # end

  # def print_albums
  #   @io.puts 'Here is the list of albums:'
  #   albums = @album_repository.all
  #   albums.each do |album|
  #     @io.puts "* #{album.id} - #{album.title}"
  #   end
  # end

  # def print_artists
  #   @io.puts 'Here is the list of artists:'
  #   artists = @artist_repository.all
  #   artists.each do |artist|
  #     @io.puts "* #{artist.id} - #{artist.name}"
  #   end
  # end
end

if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
