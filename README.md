Shop Manager Project
=================

Welcome to the Shop Manager!

You can run the program using:

```
ruby app.rb
```

The program will continuously ask for actions to perform on the database until you select option 7 to exit the program

### Database

You will need to have a database running locally named 'items_orders'.
This can be achieved by running the following in the terminal
```
createdb items_orders
```
To initialise the tables run the following:
```
psql -h 127.0.0.1 items_orders < spec/seeds_create.sql
```
If you want to import some existing data into this table you can use the provided seed by entering the following into the terminal:
```
psql -h 127.0.0.1 items_orders < spec/seeds.sql
```
>hint: this will also refresh the table with the starter data if you wish to restart after adding data!
### WARNING

Incorrect data entry wasn't in the scope of the program and can cause errors - **DOUBLE CHECK YOUR DATA ENTRY**
