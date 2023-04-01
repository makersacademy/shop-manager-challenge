require_relative './order'

class OrderRepository
  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT id, customer, date FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []

    result_set.each do |record|
      order = Order.new
      order.id = record['id']
      order.customer = record['customer']
      order.date = record['date']

      orders << order
    end

    orders
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, customer, date FROM orders WHERE id = $1;

    # Returns a single order object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(order) # needs to assign items to the order using the join table
    # INSERT INTO orders (customer, date, items) VALUES ($1, $2, $3); # items will be an array of Item objects
    # INSERT INTO items_orders (item_id, order_id) VALUES ($4, $5); # will need to loop through item
    # array and do a new insert for every item

    # when an item is added to the order, need to change the quantity - do this in app.rb?
    # item_repo = ItemRepository.new
    # item_repo.update(order.item) # loop through item array
  end

  # def update(order)
  # end

  # def delete(order)
  # end
end
