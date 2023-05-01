require 'item.rb'
require 'database_connection'

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items;

    # Returns an array of Item objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items WHERE id = $1;

    # Returns a single Item object.
  end

  # Add more methods below for each operation you'd like to implement.

  # creates a single record
  # one argument: the Item model instance
  def create(item)
    # Executes the SQL query
    # INSERT INTO artists (name, unit_price, quantity) VALUES ($1, $2, $3);

    # No return value, creates the record on database
  end

  # def update(item)
  # end

  # def delete(item)
  # end
end