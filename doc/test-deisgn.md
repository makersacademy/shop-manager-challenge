# Test Design of Shop Manager System

## Table of Contents

- [Test Design of Shop Manager System](#test-design-of-shop-manager-system)
  - [Table of Contents](#table-of-contents)
  - [Order Class Test](#order-class-test)
  - [Order Repository Class Test](#order-repository-class-test)
  - [Item Repository Class Test](#item-repository-class-test)
  - [Application Class Test](#application-class-test)

## Order Class Test

```ruby
# file: spec/order_spec.rb

# 1
# Calaulates the sum of each item in the order
items = [{name: 'tomato sauce', price: 2, quantity: 4}, {name: 'smoked salmon', price: 5, quantity: 10}]
order = Order.new(items)
order.total_price # => 58

```

## Order Repository Class Test

```ruby
# file: spec/order_repository_spec.rb

# 1
# returns all orders
repo = OrderRepository.new
orders = repo.all
today = DateTime.now.strftime("%Y-%m-%d")

orders.first.id # => '1'
orders.first.customer_name # => 'terry'
orders.first.date # => today

orders.last.id # => '3'
orders.last.customer_name # => 'luke'
orders.last.date # => today

# 2
# Creates a new order
order_repo = OrderRepository.new
item_repo = double :item_repo
item_1 = double :item, id: 1, name: 'tomato sauce', unit_price: 2, quantity: 10
item_2 = double :item, id: 2, name: 'smoked salmon', unit_price: 5, quantity: 25
order_items = [{item: item_1, quantity: 4}, {item: item_2, quantity: 10}]
order_repo.create_order('mary', order_items, item_repo)
order = order_repo.all.last

order.id # => '4'
order.customer_name # => 'mary'
order.date # => '2023-02-03'
order.items # => order_items

# 3
# Delete an order
repo = OrderRepository.new
repo.delete(3)

orders = repo.all

orders.length # => 2
orders.last.customer_name # => 'ryan'

```

## Item Repository Class Test

```ruby
# file: spec/item_repository_spec.rb

# 1
# Returns a list of Item objects
repo = ItemRepository.new
items = repo.all

items.length # => 5
items.first.name # => 'Garlic Pasta Sauce'
items.last.name # => 'Rump Steak'

# 2
# Creates a new item
repo = ItemRepository.new
repo.create_item('washing powder', 4.55, 25)

item = repo.all.last
item.id # => 6
item.name # => 'washing powder'
item.unit_price # => 4.55
item.quantity # => 25

# 3
# Adds stock of an item
repo = ItemRepository.new
repo.update_stock(1, 20, '+')

item = repo.all.first
item.id # => 1
item.name # => 'Garlic Pasta Sauce'
item.unit_price # => 1.5
item.quantity # => 50

# 4
# Decreases stock of an item
repo = ItemRepository.new
repo.update_stock(1, 5, '-')

item.id # => 1
item.name # => 'Garlic Pasta Sauce'
item.unit_price # => 1.5
item.quantity # => 25

# 5
# Updates price of an item
repo = ItemRepository.new
repo.update_price(1, 2.5)

item.id # => 1
item.name # => 'Garlic Pasta Sauce'
item.unit_price # => 2.5
item.quantity # => 30

# 6
# Removes an item from the list
repo = ItemRepository.new
repo.remove_item(1)

item = repo.all.first

item.id # => 2
item.name # => 'Shower Gel'
item.unit_price # => 2
item.quantity # => 55

# 7
# Checks if there is enough stocks
repo = ItemRepository.new
repo.is_enough_stock?(5, 10) # => false
repo.is_enough_stock?(1, 30) # => true

```

## Application Class Test

```ruby
# file: spec/application_spec.rb



```
