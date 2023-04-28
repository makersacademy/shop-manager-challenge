require_relative 'lib/database_connection'

class Application

  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts "Welcome to the shop management program!"
  end

end

# Welcome to the shop management program!

# What do you want to do?
#   1 = list all shop items
#   2 = create a new item
#   3 = list all orders
#   4 = create a new order

# 1 [enter]

# Here's a list of all shop items:

#  #1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30
#  #2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15
#  (...)
