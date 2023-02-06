# Shop Manager Project

### Ruby program to manage a shop's database using the PG Gem, the Ruby interface to the PostGreSQL database.

## 1. User stories

```
As a shop manager
So I can know which items I have in stock
I want to keep a list of my shop items with their name and unit price.

As a shop manager
So I can know which items I have in stock
I want to know which quantity (a number) I have for each item.

As a shop manager
So I can manage items
I want to be able to create a new item.

As a shop manager
So I can know which orders were made
I want to keep a list of orders with their customer name.

As a shop manager
So I can know which orders were made
I want to assign each order to their corresponding item.

As a shop manager
So I can know which orders were made
I want to know on which date an order was placed. 

As a shop manager
So I can manage orders
I want to be able to create a new order.
```


# 2. Installation

_Clone this repo and run the following commands in your terminal_

```
# make sure you have first installed Ruby
bundle
```

To run the program, open `app.rb` and uncomment the following lines of code before running `ruby app.rb` in your terminal.

```
```ruby
# the below will be executed when running 'ruby app.rb'
if __FILE__ == $0
   app = Application.new(
    'shop_manager',
     Kernel,
     ItemRepository.new,
     OrderRepository.new
   )
   app.run
end
```

## Technologies used

- Ruby
- RSpec
- Ruby Gems
- PostgreSQL database (implemented using PG Gem)
