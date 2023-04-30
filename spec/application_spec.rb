require 'application'

# Here's an example of the terminal output your program should generate:
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

def reset_test_tables
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do 
    reset_test_tables
  end

  # test here

end  
