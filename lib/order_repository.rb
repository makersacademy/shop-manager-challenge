class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, date_ordered, item_id FROM orders;
    orders = []
    #loops through results and push them into array.

    # Returns an array of orders objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, customer_name, date_ordered, item_id FROM orders WHERE id = $1;

    # Returns a single Order object.
  end

  # Add more methods below for each operation you'd like to implement.

   def create(new_item)
   # Executes the SQL query:
    # INSERT INTO orders  (id, customer_name, date_ordered, item_id) VALUES ($1, $2, $3, $4);

    # Returns nil.
  end