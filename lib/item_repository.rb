require 'item'

class ItemRepository
    # Selecting all records
    # No arguments
    def all
      # Executes the SQL query:
      # SELECT id, name, unit_price, quantity FROM items;
  
      # Returns an array of Item objects.
    end
  
    # Adds new record
    # one argument - Item Object
      def create(item)
        # Executes the SQL query:
        # INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);
        
        # Returns nil.
      end
end