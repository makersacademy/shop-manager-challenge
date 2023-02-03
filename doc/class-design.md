# Class Design of Shop Manager System

## Table of Contents

- [Class Design of Shop Manager System](#class-design-of-shop-manager-system)
  - [Table of Contents](#table-of-contents)
  - [Order Class](#order-class)
  - [Item Class](#item-class)
  - [Order Repository Class](#order-repository-class)
  - [Item Repository Class](#item-repository-class)
  - [Application Class](#application-class)

## Order Class

```ruby
# file: lib/order.rb

class Order
  attr_accessor :id, :customer_name, :date, :items

  def initialize(items = [])
    @items = items
  end

  def total_price
    # sums up all the price of all items
    # returns an integer
  end
end

```

## Item Class

```ruby
# file: lib/item.rb

class Item
  attr_accessor :id, :name, :unit_price, :quantity
end

```

## Order Repository Class

```ruby
# file: lib/order_repository.rb

class OrderRepository
  def all
    # returns an array of Order objects
  end

  def create_order(customer_name, items, item_repo)
    # creates Order objects and saves records to 'orders' and 'orders_items' table
    # steps:
    # 1. 'INSERT INTO orders (customer_name) VALUES ($1) RETURNING id;'
    # 2. order_id = Dataconnection.exec_params(sql, [customer_name])['id']
    # 3. loop through items:
    #       I. INSERT INTO orders_items (order_id, item_id, quantity) VALUES
    #             (order_id, item['item'].id, item['quantity']);
    #       II. item_repo.send_out(item_id, quantity)
  end

  def delete_order(id)
    # removes order from 'orders' table
  end
end

```

## Item Repository Class

```ruby
# file: lib/item_repository.rb

class ItemRepository
  def all
    # returns an array of Item objects
  end

  def create_item(name, price, quantity)
    # creates an Item object and save a record to database
  end

  def update_stock(id, qty, action)
    # update an item's quantity from items table
    # action : '+' or '-'
  end

  def update_price(id, price)
    # updates an item's price from items table
  end

  def remove_item(id)
    # deletes an item from items table
  end

  def is_enough_stock?(id, num)
    # returns true if the num <= quantity
  end

  private

  def is_exist?(id)
    # returns true if the record in 'items' table exists
  end
end

```

## Application Class

```ruby
# file: lib/item_repository.rb

class Application
  def initialize(db_name, io, order_repo, item_repo)
    DatabaseConnection.connect(db_name)
    @io = io
    @order_repo = order_repo
    @item_repo = item_repo
  end

  def run
    # runs the programme
    # Steps:
    # 1. Print out welcome message and options
    # 2. Ask for action
    # 3. Check the response:
    #     1 = list all shop items
    #     2 = create a new item
    #     3 = update an item's price
    #     4 = update stock of an item
    #     5 = list all orders
    #     6 = create a new order
    #     7 = quit
    # 4. execute action
    # 5. loop back to step 1
  end

  private

  def list_items
    # prints out list of items on terminal
    # => Here's a list of all shop items:
    # =>  1. Super Shark Vacuum Cleaner - Unit price: 10 - Quantity: 30
    # =>  2. Makerspresso Coffee Machine - Unit price: 20 - Quantity: 15
  end

  def list_orders
    # prints out list of orders on terminal
    # => Here's a list of all orders:
    # =>  1. 2023-02-03 Terry's Order:
    # =>    ----------
    # =>    Items:
    # =>      - Super Shark Vacuum Cleaner - Qty: 2
    # =>      - Makerspresso Coffee Machine - Qty: 5
    # =>    ----------
    # =>    Grand total: $120
    # =>    -------------------------------------------
    # =>  2. 2023-02-03 Terry's Order:
    # =>    ----------
    # =>    Items:
    # =>      - Super Shark Vacuum Cleaner - Qty: 2
    # =>    ----------
    # =>    Grand total: $20
    # =>    ----------

  end

  def create_order
    # asks questions about the order:
    #   1. name
    #   loop:
    #     2. item id
    #     3. qty (can't be 0)
    #     4. check stock by calling 'is_enough_stock?'
    #     4. print out message & go back to 2 if there is no enough stock
    #     5. continue or done?
    #   end
    # calls 'create_order' from OrderRepository
    # print out 'Successfully created an order!'
  end

  def create_item
    # asks for inputs:
    #   1. item name
    #   2. price
    #   3. quantity
    # calls 'create_item' from ItemRepository
  end

  def update_price
    # asks for inputs:
    #   1. item id
    #   2. latest price
    # calls 'update_price' from ItemRepository
  end

  def update_stock
    # asks for inputs:
    #   1. add / send out?
    #   1. item id
    #   2. quantity
    # calls 'update_stock' from ItemRepository
  end

end

```
