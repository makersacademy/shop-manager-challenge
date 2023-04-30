# Artist Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: students

Columns:
id | name | cohort_name
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE recipes RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO recipes (name, average_cooking_time, rating) VALUES ('Stir Fry Noodles', '30', '5');
INSERT INTO recipes (name, average_cooking_time, rating) VALUES ('Baked Potato', '60', '4');
INSERT INTO recipes (name, average_cooking_time, rating) VALUES ('Carbonara', '30', '4');
INSERT INTO recipes (name, average_cooking_time, rating) VALUES ('Cacio e pepe', '45', '4');
INSERT INTO recipes (name, average_cooking_time, rating) VALUES ('Tiramisù', '60', '5');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_recipes.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: items

# Model class
# (in lib/recipe.rb)
class Item
end

# Repository class
# (in lib/recipe_repository.rb)
class RecipeRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: items

# Model class
# (in lib/item.rb)

class Item
    
    attr_accessor :id, :name, :price, :quantity
end

```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby

# Table name: items

# Repository class
# (in lib/item_repository.rb)

class ItemRepository
    def all
        # shows all items
        sql = 'SELECT id, name, price, quantity FROM items;'
        result = DatabaseConnection.exec_params(sql, [])

        items = []

        result.each do |record|
            item = Item.new
            item.id = record['id']
            item.name = record['name']
            item.price = record['price']
            item.quantity = record['quantity']
        end
    end

    def find(id)
    end

    def create(item)
    end

    def delete(item)
    end

end

# EXAMPLE
# Table name: recipe

# Repository class
# (in lib/recipe_repository.rb)

    def find(id)
    # SELECT id, name, price, quantity FROM items WHERE id = $1;
    end

    def create(album)
        sql = 'INSERT INTO albums
                    (title, release_year, artist_id)
                    VALUES($1, $2, $3);'
        sql_params = [album.title, album.release_year, album.artist_id]

        DatabaseConnection.exec_params(sql, sql_params)

        return nil
    end

      
    def delete(id)
      sql = 'DELETE FROM accounts WHERE id = $1;'
      sql_params = [id]

      DatabaseConnection.exec_params(sql, sql_params)

      return nil
    end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby

  # 1
        it 'shows all items' do
            repo = ItemRepository.new

            items = repo.all
            expect(items.length).to eq 4
            expect(items.first.id).to eq '1'
            expect(items.first.name).to eq 'Eggs'
        end
  # 2
        it 'returns a single item' do
            repo = ItemRepository.new

            item = repo.find(1)
            expect(item.name).to eq 'Eggs'
            expect(item.price).to eq '2.99'
        end
  # 3
        it 'returns another item' do
            repo = ItemRepository.new

            item = repo.find(2)
            expect(item.name).to eq 'Coffee'
            expect(item.price).to eq '5.99'
        end

        # it "create a new album record" do
        #   repo = AlbumRepository.new

        #   new_album = Album.new
        #   new_album.title = 'Trompe le Monde'
        #   new_album.release_year = 1991
        #   new_album.artist_id = 1
          
        #   repo.create(new_album)
        #   all_albums = repo.all

        #   expect(all_albums).to include(
        #     have_attributes(
        #       title: new_album.title,
        #       release_year: '1991'
        #     )
        #   )   
        #   last_album = all_albums.last
        #   expect(last_album.title).to eq 'Trompe le Monde'
        #   expect(last_album.release_year).to eq '1991'

        # end

        # it 'deletes an existing account' do
        #     repo = AccountRepository.new
        #     id_to_delete = 1
        #     repo.delete(id_to_delete)

        #     all_accounts = repo.all
        #     expect(all_accounts.length).to eq 1
        #     expect(all_accounts.first.id).to eq '2'

        # end


Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/recipe_repository_spec.rb

def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipes.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before(:each) do 
    reset_recipes_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->