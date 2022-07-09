# file: app.rb

require_relative 'database_connection'
require 'item_repository'

class Application
  def initialize(database_name, io, item_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
  end

  def run
    @io.puts('Welcome to the shop management program!')
    @io.puts('What do you want to do?')
    @io.puts('1 = list all shop items 2 = create a new item 3 = list all orders 4 = create a new order')
    choice = @io.gets.chomp
    result = ""
    
    if choice == '1'
      @item_repository.all.each do |item| result << "#{item.item_name} #{item.unit_price}" end
    end

    return result
  end
end

# We need to give the database name to the method `connect`.