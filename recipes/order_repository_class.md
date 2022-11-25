# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `albums`*

```
# EXAMPLE

Table: albums

Columns:
id | title | release_year | artist_id
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

TRUNCATE TABLE albums RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO albums (title, release_year, artist_id) VALUES ('The Dark Side Of The Moon', '1973', 5);
INSERT INTO albums (title, release_year, artist_id) VALUES ('Unplugged (Deluxe Edition)', '1992', 6);


```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: artists

# Model class
# (in lib/artist.rb)
class Album
end

# Repository class
# (in lib/artist_repository.rb)
class AlbumRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: artists

# Model class
# (in lib/artist.rb)

class Album
  attr_accessor :id, :title, :release_year, :artist_id
end



# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: artists

# Repository class
# (in lib/albums_repository.rb)

require_relative './album'

class AlbumRepository
  def all
    sql = 'SELECT id, title, release_year, artist_id FROM albums;'
    result_set = DatabaseConnection.exec_params(sql, [])

    albums = []

    result_set.each do |record|
      album = Album.new
      album.id = record['id']
      album.title = record['title']
      album.release_year = record['release_year']
      album.artist_id = record['artist_id']
      albums << album
    end
    return albums
  end


  def find(id)
    # Executes the SQL query:
    sql = 'SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record  = result_set[0]
    album = Album.new
    album.id = record['id']
    album.title = record['title']
    album.release_year = record['release_year']
    album.artist_id = record['artist_id']
    return album
  end



  # Add more methods below for each operation you'd like to implement.


  # Insert a new album record
  # Takes an Album object as argument
  def create(album)
    # Executes the SQL query:
    #INSERT INTO albums (title, release_year, artist_id) VALUES ( $1, $2, $3);

    # Doesn't return anything, only creates the record

  end

  # Updates an album record
  # takes an Album object with the updated fields
  def update(album)
    # Executes the SQL query:
    # UPDATE album SET title = $1, release_year = $2, artist_id = $3 WHERE id = $4;
    # Doesn't return anything, only updtates the record


  end

  # Deletes an album record
  # given its id
  def delete(student)
    # Executes the SQL query:
    # DELETE FROM album WHERE id = $1;
    # Doesn't return anything, only deletes the record

  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1

repo = AlbumRepository.new
albums = repo.all
albums.length # => (2)
albums.first.id # =>('1')
albums.first.title # => ('The Dark Side Of The Moon')



# 2

repo = AlbumRepository.new
album = repo.find(2)
album.title # => 'Unplugged (Deluxe Edition)'
album.release_year # => '1992'


# 3 Create a new album

repo = AlbumRepository.new
new_album = Album.new
new_album.title = 'Trompe le Monde'
new_album.release_year = 1991
new_album.artist_id = 1

repo.create(new_album) # => nil

albums = repo.all
last_album =  albums.last
last_album.title # => 'Trompe le Monde'
last_album.release_year # => 1991



# 4 Deletes an album

repo = AlbumRepository.new
id_to_delete = 1

repo.delete(id_to_delete)

all_albums = repo.all
all_albums.length # => 1
all_albums.first.id # => '2'




# 5 Deletes an album

repo = AlbumRepository.new

album = repo.find(1)

album.title = 'Hello Hello'
album.release_year = 9999
album.artist_id = 9999

repo.update(album)

updated_album = repo.find(1)
updated_album.title # => 'Hello hello'
updated_album.release_year # => 9999











# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_table
  seed_sql = File.read('spec/seedsXXXX.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'XXXXX' })
  connection.exec(seed_sql)
end


before(:each) do
  reset_table
end

  # (your tests will go here).

```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
