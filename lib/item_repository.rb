class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, item, price, quantity FROM items;
    items = []
    #loops through results and push them into array.

    # Returns an array of items objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, item, price, quantity FROM items; WHERE id = $1;

    # Returns a single Item object.
  end

  # Add more methods below for each operation you'd like to implement.

   def create(new_item)
   # Executes the SQL query:
    # INSERT INTO items  (id, item, price, quantity) VALUES ($1, $2, $3);

    # Returns nil.
  end

  # def update(student)
  # end

  # def delete(student)
  # end
end