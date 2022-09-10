require_relative './item_repository'
require_relative './order_repository'
require_relative './database_connection'

class Application

  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def print_all_items
    result = @item_repository.all_items
    result.each do |item|
      @io.puts "##{item.id} - #{item.name} - Price: #{item.price} - Stock quantiy: #{item.stock_qty}"
    end
  end


  def print_all_albums
    result = @album_repository.all
    result.each do |album|
      @io.puts "#{album.id} - #{album.title}"
    end
  end
end