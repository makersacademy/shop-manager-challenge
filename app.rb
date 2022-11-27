require 'lib/database_connection'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('INSERT_DATABASE_NAME')








# Here's an example of the terminal output your program should generate (yours might be slightly different — that's totally OK):

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