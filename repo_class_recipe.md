# ORDERS & ITEMS Model and Repository Classes Design Recipe

## Define the Repository Class interface


### ITEMS
```ruby
class ItemRepository
  def all
    # To "list all items"
    # Returns a list of Item objects
  end

  def create(item)
    # For "creating new item"
    # Creates a new Item object
  end

  def update(item)
    # For reducing Item quantity after making an order.
    # And also for updating the updating the item q. 
    # which is already in stock.
    # Updates an Item object of the specified id
  end
end

```

### ORDERS
```ruby
class OrderRepository
  def all
    # For "list all orders"
    # Returns a list of Order objects 
    # and each list should also have a list of Item objects
  end
  
  def create(order_id)
    # For "creating new order"
    # Creates a new Order object.
    # Should also reduce the quantity of corresponding 
    # Item object.
    #
  end
end
```
